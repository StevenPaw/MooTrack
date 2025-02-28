using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[System.Serializable]
public class AppPage
{
    [SerializeField] private string name;
    [SerializeField] private GameObject pageObject;
    [SerializeField] private AppPages type;

    public string Name
    {
        get { return name; }
        set { name = value; }
    }

    public GameObject PageObject
    {
        get { return pageObject; }
        set { pageObject = value; }
    }

    public AppPages Type
    {
        get { return type; }
        set { type = value; }
    }
}
