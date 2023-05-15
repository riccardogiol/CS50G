using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class ReloadSceneOnInput : MonoBehaviour
{
    public string SceneName;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetAxis("Submit") == 1)
        {
            SceneManager.LoadScene(SceneName);
        }
        
    }
}