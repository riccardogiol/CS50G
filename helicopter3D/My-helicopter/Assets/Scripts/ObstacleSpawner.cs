using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ObstacleSpawner : MonoBehaviour
{
    public GameObject[] buildingPrefabs;
    void Start()
    {
        StartCoroutine(SpawnBuildings());
    }

    void Update()
    {
        
    }

    IEnumerator SpawnBuildings() 
    {
        while (true)
        {
            Instantiate(buildingPrefabs[Random.Range(0, buildingPrefabs.Length)], new Vector3(15, Random.Range(-8, -4), 0), Quaternion.Euler(-90f, 0f, 0f));
            yield return new WaitForSeconds(Random.Range(3, 7));
        }
    }
}
