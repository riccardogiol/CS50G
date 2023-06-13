using UnityEngine;
using System.Collections;

public class GameOverTrigger : MonoBehaviour {
	public bool gameOver = false;

	void Start () {}
	void Update () {}

	void OnTriggerEnter(Collider other) {

		if (other.gameObject.tag == "Player") {
			gameOver = true;
		}
	}
}
