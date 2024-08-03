using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class ListEntryCard : MonoBehaviour
{
    [SerializeField] private TMP_Text entryText;
    [SerializeField] private TMP_Text entryDate;
    [SerializeField] private Image emotionImage;
    [SerializeField] private Image backgroundImage;
    [SerializeField] private LogEntry logEntry;

    // Start is called before the first frame update
    void Start()
    {
        if(logEntry != null)
        {
            entryText.text = logEntry.entryText;
            entryDate.text = logEntry.entryDate.DateTime.ToString();
            emotionImage.sprite = logEntry.emotion.icon;
            backgroundImage.color = logEntry.emotion.color;
        }
    }

    public void SetLogEntry(LogEntry entry)
    {
        logEntry = entry;
    }
}
