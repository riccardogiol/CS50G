using System.Collections;
using UnityEngine;
using UnityEngine.UI;

public class UpdateScore : MonoBehaviour
{

	private Text textComp;
	private int mazeNr;
    // Start is called before the first frame update
    void Start()
    {
        textComp = GetComponent<Text>();
    }

    // Update is called once per frame
    void Update()
    {
        mazeNr = DontDestroy.instance.GetComponent<MazeCounter>().score;
        textComp.text = "Maze number " + mazeNr;
    }
}
