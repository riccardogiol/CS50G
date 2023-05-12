using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CoinSpawner : MonoBehaviour
{
    public GameObject coinPrefab;
    void Start() 
    {
        StartCoroutine(SpawnCoins());
    }

    void Update() {}

    IEnumerator SpawnCoins() 
    {
        while (true)
        {
            int CoinsThisRow = Random.Range(1,4);

            for (int i = 0; i < CoinsThisRow; i++)
            {
                Instantiate(coinPrefab, new Vector3(15, Random.Range(-2, 4), 0), Quaternion.identity);
            }

            yield return new WaitForSeconds(Random.Range(2,4));
        }
    }
}
