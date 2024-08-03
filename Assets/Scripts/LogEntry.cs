using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[System.Serializable]
public class LogEntry
{
    [SerializeField] public string entryText;
    [SerializeField] public EmotionEntry emotion;
    [SerializeField] public Feelings feeling;
    [SerializeField] public SerializableDateTime entryDate;
}
