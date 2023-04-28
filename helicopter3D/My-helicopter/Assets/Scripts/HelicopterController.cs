using System.Collections;
using System.Collections.Generic;
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
        rb.velocity = new Vector3(horizontal, vertical, 0);
    }
}
