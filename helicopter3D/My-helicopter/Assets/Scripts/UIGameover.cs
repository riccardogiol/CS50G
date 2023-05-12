using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;

public class UIGameover : MonoBehaviour
{
    public GameObject helicopter;
    private Text text;

    void Start()
    {
       text =  GetComponent<Text>();
       text.color = new Color(1, 1, 1, 0);
    }

    void Update()
    {
        if (helicopter == null)
        {
            text.color = new Color(1, 1, 1, 1);
            if (Input.GetButtonDown("Jump"))
            {
				SceneManager.LoadScene("Main");
			}
        }
        
    }
}
