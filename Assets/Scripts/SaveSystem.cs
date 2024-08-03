using System.Collections.Generic;
using UnityEngine;

public static class SaveSystem
{
	public static List<LogEntry> logEntries = new List<LogEntry>();

	public static void addEntry(LogEntry entry)
	{
        logEntries.Add(entry);
    }

	public static void SaveEntries()
	{
        System.IO.File.Delete(Application.persistentDataPath + "/logEntries.json");
        // Save the log entries to a file
        foreach (LogEntry entry in logEntries)
		{
			//Serialize the log entry
			string json = JsonUtility.ToJson(entry);
			//Save the log entry to a file
			System.IO.File.AppendAllText(Application.persistentDataPath + "/logEntries.json", json + "\n");
		}
	}

	public static List<LogEntry> LoadEntries()
	{
		//Check if save file exists
		if (!System.IO.File.Exists(Application.persistentDataPath + "/logEntries.json"))
		{
            //If the file does not exist, create it
            System.IO.File.Create(Application.persistentDataPath + "/logEntries.json").Close();
        }

		// Load the log entries from a file
        logEntries.Clear();
		//Read the log entries from a file
		Debug.Log(Application.persistentDataPath + "/logEntries.json");
		string[] lines = System.IO.File.ReadAllLines(Application.persistentDataPath + "/logEntries.json");
        foreach (string line in lines)
		{
            //Deserialize the log entry
            LogEntry entry = JsonUtility.FromJson<LogEntry>(line);
            //Add the log entry to the list
            logEntries.Add(entry);
        }
        return logEntries;
	}
}