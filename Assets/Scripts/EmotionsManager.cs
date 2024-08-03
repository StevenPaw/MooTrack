using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EmotionsManager : MonoBehaviour
{

    public EmotionEntry[] emotions;
    public GameObject emotionsListHolder;
    public GameObject emotionPrefab;

    // Start is called before the first frame update
    void Start()
    {
        //Clean the emotionsListHolder.
        foreach(Transform child in emotionsListHolder.transform)
        {
            Destroy(child.gameObject);
        }
        foreach(EmotionEntry emotion in emotions)
        {
            GameObject newEmotion = Instantiate(emotionPrefab, emotionsListHolder.transform);
            newEmotion.GetComponent<EmotionButton>().emotion = emotion;
        }
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}


public enum Emotions
{
    None,
    Happy,
    Sad,
    Angry,
    Surprised,
    Disgusted,
    Scared,
    Inspired,
    Loving,
    Bored,
    Excited,
    Tired,
    Relaxed,
    Neutral,
}