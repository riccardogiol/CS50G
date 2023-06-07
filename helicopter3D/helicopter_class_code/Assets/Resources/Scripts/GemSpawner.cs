using UnityEngine;
using System.Collections;

public class GemSpawner : MonoBehaviour {

	public GameObject prefab;

	void Start () {
		StartCoroutine(SpawnGems());
	}

	void Update () {}

	IEnumerator SpawnGems() {
		while (true) {
			//Debug.Log("New gem speed: " + SkyscraperSpawner.speed);
			Instantiate(prefab, new Vector3(26, Random.Range(-10, 10), 10), Quaternion.identity);
			yield return new WaitForSeconds(Random.Range(4, 10));
		}
	}
}
