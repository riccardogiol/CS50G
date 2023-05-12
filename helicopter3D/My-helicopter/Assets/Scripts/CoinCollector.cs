using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CoinCollector : MonoBehaviour
{
    public int totalScore = 0;
    void Start()
    {
        totalScore = 0;
    }

    void Update()
    {
        
    }

    public void PickupCoin(int score)
    {
        totalScore += score;
        gameObject.GetComponent<ParticleSystem>().Play();
    }
}
