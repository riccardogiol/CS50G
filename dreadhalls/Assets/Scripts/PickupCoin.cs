using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class PickupCoin : MonoBehaviour
{
    private AudioSource pickupSound;
    // Start is called before the first frame update
    void Start()
    {
        pickupSound = DontDestroy.instance.GetComponents<AudioSource>()[1];
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.tag == "Player")
        {   
            pickupSound.Play();
            SceneManager.LoadScene("Play");
        }
    }
}
