using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class DespawnOnHeight : MonoBehaviour
{
    public int heightLimit;
    
    private AudioSource gameOverSoundSource;

    // Start is called before the first frame update
    void Start()
    {
        gameOverSoundSource = DontDestroy.instance.GetComponents<AudioSource>()[2];
        
    }

    // Update is called once per frame
    void Update()
    {
        if (transform.position.y < heightLimit)
        {
            gameOverSoundSource.Play();
            SceneManager.LoadScene("GameOver");
        }
        
    }
}
