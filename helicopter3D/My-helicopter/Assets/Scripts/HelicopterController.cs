using System.Collections;
using System.Collections.Generic;
using System;
using UnityEngine;

public class HelicopterController : MonoBehaviour
{
    public float speed = 10.0f;
    private float horizontal, vertical;
    private Rigidbody rb;

    void Start()
    {
        rb = GetComponent<Rigidbody>();
    }

    void Update()
    {
        vertical = Input.GetAxis("Vertical") * speed;
        horizontal = Input.GetAxis("Horizontal") * speed;

        if (transform.position.x < -10)
        {
            horizontal = Math.Max(0, horizontal);
        }
        if (transform.position.x > 12)
        {
            horizontal = Math.Min(0, horizontal);
        }
        if (transform.position.y < -3) 
        {
            vertical = Math.Max(0, vertical);
        }
        if (transform.position.y > 5)
        {
            vertical = Math.Min(0, vertical);
        }

        rb.velocity = new Vector3(horizontal, vertical, 0);
    }
}
