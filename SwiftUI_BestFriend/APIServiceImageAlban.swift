//
//  APIServiceImage.swift
//  MonMeilleurCopain
//
//  Created by Al on 10/11/2023.
//

import Foundation

class APIServiceImageAlban {
    let baseURL = "http://127.0.0.1:8080" // Remplacez cela par l'URL réelle de votre API

    func sendCompletionRequest(prompt: String, temperature: Double = 0.8, topK: Int = 40, topP: Double = 0.95, minP: Double = 0.05, nPredict: Int = 32, nKeep: Int = 0, stream: Bool = false, stop: [String] = [], tfsZ: Double = 1.0, typicalP: Double = 1.0, repeatPenalty: Double = 1.1, repeatLastN: Int = 64, penalizeNL: Bool = true, presencePenalty: Double = 0.0, frequencyPenalty: Double = 0.0, mirostat: Int = 0, mirostatTau: Double = 5.0, mirostatEta: Double = 0.1, grammar: String = "", seed: Int = -1, ignoreEOS: Bool = false, logitBias: [[Any]] = [], nProbs: Int = 0, imageData: [[String: Any]] = []) {
        
        let endpoint = "/completion"
        let urlString = baseURL + endpoint

        guard let url = URL(string: urlString) else {
            print("URL is not valid.")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let parameters: [String: Any] = [
            "prompt": prompt,
            "temperature": temperature,
            "top_k": topK,
            "top_p": topP,
            "min_p": minP,
            "n_predict": nPredict,
            "n_keep": nKeep,
            "stream": stream,
            "stop": stop,
            "tfs_z": tfsZ,
            "typical_p": typicalP,
            "repeat_penalty": repeatPenalty,
            "repeat_last_n": repeatLastN,
            "penalize_nl": penalizeNL,
            "presence_penalty": presencePenalty,
            "frequency_penalty": frequencyPenalty,
            "mirostat": mirostat,
            "mirostat_tau": mirostatTau,
            "mirostat_eta": mirostatEta,
            "grammar": grammar,
            "seed": seed,
            "ignore_eos": ignoreEOS,
            "logit_bias": logitBias,
            "n_probs": nProbs,
            "image_data": imageData
        ]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters)
            request.httpBody = jsonData
            print(jsonData)
        } catch {
            print("Error converting parameters to JSON.")
            return
        }

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }

            guard let data = data else {
                print("No data received.")
                return
            }

            do {
                //print(data)
                //let json = try JSONSerialization.jsonObject(with: data, options: [])
                let aPIResponse = try? JSONDecoder().decode(APIResponse.self, from: data)
                
                
                print("Response JSON: \(aPIResponse)")
                // Handle the JSON response here
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }

        task.resume()
    }
}

/*
var message = Message(userName: "Me", dataType: .Image,data: UIImage(named: "maison")!.pngData())
apiServiceImage.sendCompletionRequest(prompt: "Quel est la couleur des volets",
imageData:  [ ["data":message.getBase64Image()!,"id":1]])
*/
