using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class AddEntryManager : MonoBehaviour
{
    public GameObject emotionsSlide; //Step 1: Select Emotion
    public GameObject feelingsSlide; //Step 2: Select Feeling
    public GameObject addEntryPanel; //Step 3: Add Entry with Text
    public TMP_Text titleText;
    public Slider feelingsSlider;
    public TMP_InputField entryText;

    public string emotionsTitle;
    public string feelingsTitle;
    public string addEntryTitle;

    public EmotionEntry selectedEmotion;
    public Feelings selectedFeeling;

    public List<LogEntry> logEntries;

    // Start is called before the first frame update
    void Start()
    {
        StartNewEntry();
        logEntries = SaveSystem.LoadEntries();
    }

    // Update is called once per frame
    void Update()
    { }

    public void SetClickedEmotion(EmotionEntry clickedEntry)
    {
        selectedEmotion = clickedEntry;
        emotionsSlide.SetActive(false);
        feelingsSlide.SetActive(true);
        addEntryPanel.SetActive(false);
        titleText.text = feelingsTitle;
    }

    public void SetSelectedFeeling()
    {
        emotionsSlide.SetActive(false);
        feelingsSlide.SetActive(false);
        addEntryPanel.SetActive(true);
        if(selectedEmotion != null && selectedEmotion.questionForMore != null)
        {
            titleText.text = selectedEmotion.questionForMore;
        }
        else
        {
            titleText.text = addEntryTitle;
        }
    }

    public void StartNewEntry()
    {
        selectedEmotion = null;
        selectedFeeling = Feelings.NONE;
        emotionsSlide.SetActive(true);
        feelingsSlide.SetActive(false);
        addEntryPanel.SetActive(false);
        titleText.text = emotionsTitle;
        feelingsSlider.value = 2;
        entryText.text = "";
    }

    public void ChangeFeelingSelected()
    {
        switch((int)feelingsSlider.value)
        {
            case 0:
                selectedFeeling = Feelings.SUPERGOOD;
                break;
            case 1:
                selectedFeeling = Feelings.GOOD;
                break;
            case 2:
                selectedFeeling = Feelings.NEUTRAL;
                break;
            case 3:
                selectedFeeling = Feelings.BAD;
                break;
            case 4:
                selectedFeeling = Feelings.SUPERBAD;
                break;
            default:
                selectedFeeling = Feelings.NONE;
                break;
        }
    }

    public void AddEntry()
    {
        Debug.Log("Entry added: " + selectedEmotion.name + " - " + selectedFeeling.ToString() + " | TODO!");
        LogEntry newEntry = new LogEntry();
        newEntry.emotion = selectedEmotion;
        newEntry.feeling = selectedFeeling;
        newEntry.entryText = entryText.text;
        newEntry.entryDate = new SerializableDateTime(System.DateTime.Now);
        SaveSystem.addEntry(newEntry);
        StartNewEntry();
        GameObject.FindObjectOfType<ListManager>().AddNewEntry(newEntry);
    }

    public void OnApplicationQuit()
    {
        Debug.Log("Saving log entries...");
        SaveSystem.SaveEntries();
    }
}

public enum Feelings
{
    NONE,
    SUPERGOOD,
    GOOD,
    NEUTRAL,
    BAD,
    SUPERBAD
}