using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;


public class UIScoreCounter : MonoBehaviour
{
    public CoinCollector cc;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        Text text = gameObject.GetComponent<Text>();
        text.text = "Score: " + cc.totalScore;
    }
}
