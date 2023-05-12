using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ShiftingObject : MonoBehaviour
{
    public float speed = 5;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if (transform.position.x < -25)
        {
            Destroy(gameObject);
        }
        else
        {
            transform.Translate(-speed * Time.deltaTime, 0, 0, Space.World);
        }

    }
}
