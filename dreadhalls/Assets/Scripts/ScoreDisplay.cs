using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ScoreDisplay : MonoBehaviour
{
    public GameObject scoreCounter;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        int score = scoreCounter.GetComponent<ScoreCounter>().score;
        Text text = gameObject.GetComponent<Text>();
        text.text = "Score: " + score;
        
    }
}
