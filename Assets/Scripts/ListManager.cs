using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class ListManager : MonoBehaviour
{
    public GameObject listHolder;
    public GameObject listItemPrefab;
    public List<LogEntry> items;

    private void Start()
    {
        // Get All Items from Save Manager
        items = SaveSystem.LoadEntries();

        if(items.Count <= 0)
        {
            return;
        }

        //remove all children from holder
        foreach (Transform child in listHolder.transform)
        {
            Destroy(child.gameObject);
        }

        //Fill listHolder with items
        foreach (LogEntry item in items)
        {
            GameObject listItem = Instantiate(listItemPrefab, listHolder.transform);
            listItem.GetComponent<ListEntryCard>().SetLogEntry(item);
        }
    }

    public void AddNewEntry(LogEntry entry)
    {
        //Add new entry before the other entries
        GameObject listItem = Instantiate(listItemPrefab, listHolder.transform);
        listItem.GetComponent<ListEntryCard>().SetLogEntry(entry);
    }
}