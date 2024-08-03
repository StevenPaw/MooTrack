using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AppManager : MonoBehaviour
{
    [SerializeField] private AppPages currentSlide = AppPages.List;
    public AppPage[] appPages;

    public void ChangePage (string slide)
    {
        switch (slide)
        {
            case "Add":
                currentSlide = AppPages.Add;
                break;
            case "List":
                currentSlide = AppPages.List;
                break;
            case "Detail":
                currentSlide = AppPages.Detail;
                break;
            case "Cloth":
                currentSlide = AppPages.Cloth;
                break;
            case "Settings":
                currentSlide = AppPages.Settings;
                break;
            default:
                break;
        }

        foreach (AppPage page in appPages)
        {
            if (page.Type == currentSlide)
            {
                page.PageObject.SetActive(true);
            }
            else
            {
                page.PageObject.SetActive(false);
            }
        }
    }   
}

public enum AppPages
{
    None,
    Add,
    List,
    Detail,
    Cloth,
    Settings
}
