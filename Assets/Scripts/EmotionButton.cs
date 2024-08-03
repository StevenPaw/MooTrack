using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class EmotionButton : MonoBehaviour
{
    public EmotionEntry emotion;
    public Image icon;
    public Image background;
    public TMP_Text emotionName;
    public Button button;

    private AddEntryManager addEntryManager;

    // Start is called before the first frame update
    public void Start()
    {
        addEntryManager = FindObjectOfType<AddEntryManager>();
        if(addEntryManager == null)
        {
            Debug.LogError("AddEntryManager not found");
        }
        button.onClick.AddListener(OnButtonClicked);

        if(emotion == null)
        {
            Debug.LogError("Emotion is null");
            return;
        }
        if(emotion.icon != null)
        {
            icon.sprite = emotion.icon;
        }
        background.color = emotion.color;
        emotionName.text = emotion.name;
    }

    public void OnButtonClicked()
    {
        addEntryManager.SetClickedEmotion(emotion);
        Debug.Log("Emotion clicked: " + emotion.name);
    }
}