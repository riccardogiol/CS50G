using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DestroyDontDestroy : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        if (DontDestroy.instance != null )
        {
            Destroy(DontDestroy.instance.gameObject);
        }
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
