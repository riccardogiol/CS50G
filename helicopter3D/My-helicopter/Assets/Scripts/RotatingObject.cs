using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RotatingObject : MonoBehaviour
{
    public float xVelocity, yVelocity, zVelocity;

    void Start()
    {
        
    }

    void Update()
    {
        transform.Rotate(new Vector3(xVelocity, yVelocity, zVelocity));
    }
}
