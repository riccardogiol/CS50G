using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GenerateLabyrinth : MonoBehaviour
{
    public GameObject player;
    public GameObject coin;

    public GameObject floorBlock;
    public GameObject floorParent;
    public GameObject wallBlock;
    public GameObject wallParent;
    public GameObject ceilingBlock;
    public GameObject ceilingParent;
    public GameObject gameoverBlock;
    public GameObject gameoverBlockParent;
    public bool ceilingON;

    private bool[,] map;
    public int mapSize;
    private int startingPositionX;
    private int startingPositionZ;
    // Start is called before the first frame update
    void Start()
    {
        startingPositionX = Random.Range(1, mapSize - 2);
        startingPositionZ = Random.Range(1, mapSize - 2);
        player.GetComponent<CharacterController>().enabled = false;
        player.transform.SetPositionAndRotation(new Vector3(startingPositionX, 2, startingPositionZ), Quaternion.identity);
        CreateChildPrefab(floorBlock, floorParent, startingPositionX, 0, startingPositionZ);
        player.GetComponent<CharacterController>().enabled = true;
        map = GenerateMap();
        for (int z=0; z<mapSize; z++)
        {
            for (int x=0; x<mapSize; x++)
            {
                if (map[z, x])
                {
                    CreateChildPrefab(wallBlock, wallParent, x, 3, z);
                    CreateChildPrefab(floorBlock, floorParent, x, 0, z);
                } else
                {
                    if (Random.value > 0.05)
                    {
                        CreateChildPrefab(floorBlock, floorParent, x, 0, z);
                    } else
                    {
                        CreateChildPrefab(gameoverBlock, gameoverBlockParent, x, -3, z);
                    }
                }
                if (ceilingON)
                {
                    CreateChildPrefab(ceilingBlock, ceilingParent, x, 4, z);
                }
            }
        }

    }

    bool[,] GenerateMap()
    {
        bool[,] map = new bool[mapSize, mapSize];
        for (int z=0; z<mapSize; z++)
        {
            for (int x=0; x<mapSize; x++)
            {
                map[z, x] = true;
            }
        }

        int wallsRemoved = 0;
        int diggingPositionX = startingPositionX;
        int diggingPositionZ = startingPositionZ;
        int finalX = startingPositionX;
        int finalZ = startingPositionZ;
        int distance;
        map[diggingPositionZ, diggingPositionX] = false;
        bool moovingOnX = true;
        bool moovingOnward;
        while(wallsRemoved < 300)
        {
            moovingOnX = !moovingOnX;
            moovingOnward = Random.value > 0.5;
            distance = Random.Range(3, mapSize);
            if (moovingOnX)
            {
                if (moovingOnward)
                {
                    finalX = Mathf.Clamp(diggingPositionX + distance, 1, mapSize - 2);
                    while (diggingPositionX < finalX)
                    {
                        diggingPositionX++;
                        if (map[diggingPositionZ, diggingPositionX])
                        {
                            map[diggingPositionZ, diggingPositionX] = false;
                            wallsRemoved++;
                        }
                    }
                }
                else
                {
                    finalX = Mathf.Clamp(diggingPositionX - distance, 1, mapSize - 2);
                    while (diggingPositionX > finalX)
                    {
                        diggingPositionX--;
                        if (map[diggingPositionZ, diggingPositionX])
                        {
                            map[diggingPositionZ, diggingPositionX] = false;
                            wallsRemoved++;
                        }
                    }
                }
            }
            else
            {
                if (moovingOnward)
                {
                    finalZ = Mathf.Clamp(diggingPositionZ + distance, 1, mapSize - 2);
                    while (diggingPositionZ < finalZ)
                    {
                        diggingPositionZ++;
                        if (map[diggingPositionZ, diggingPositionX])
                        {
                            map[diggingPositionZ, diggingPositionX] = false;
                            wallsRemoved++;
                        }
                    }
                }
                else
                {
                    finalZ = Mathf.Clamp(diggingPositionZ - distance, 1, mapSize - 2);
                    while (diggingPositionZ > finalZ)
                    {
                        diggingPositionZ--;
                        if (map[diggingPositionZ, diggingPositionX])
                        {
                            map[diggingPositionZ, diggingPositionX] = false;
                            wallsRemoved++;
                        }
                    }
                }
            }
        }
        Instantiate(coin, new Vector3(finalX, 1.3f, finalZ), Quaternion.identity);
        return map;
    }

    void CreateChildPrefab(GameObject prefab, GameObject parent, int x, int y, int z)
    {
        var newPrefab = Instantiate(prefab, new Vector3(x, y, z), Quaternion.identity);
        newPrefab.transform.parent = parent.transform;
    }



    // Update is called once per frame
    void Update()
    {
        
    }
}
