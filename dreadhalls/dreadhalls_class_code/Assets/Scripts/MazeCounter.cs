using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MazeCounter : MonoBehaviour
{
    public int score = 1;
    // Start is called before the first frame update
    void Start()
    {
        score = 1; 
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public void AddScore()
    {
        score += 1;
    }
}
