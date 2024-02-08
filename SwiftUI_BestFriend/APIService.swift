//
//  APIService.swift
//  MonMeilleurCopain
//
//  Created by Al on 10/11/2023.
//

import Foundation


class APIService {
    let baseURL = "http://192.168.4.52:8080" // Remplacez cela par l'URL réelle de votre API
    let setting = Settings.instance

    func sendCompletionRequest(prompt: String, temperature: Double = 0.8, topK: Int = 40, topP: Double = 0.95, minP: Double = 0.05, nPredict: Int = Int(Settings.instance.predictions), nKeep: Int = 0, stream: Bool = false, stop: [String] = ["\(Settings.instance.username):"], tfsZ: Double = 1.0, typicalP: Double = 1.0, repeatPenalty: Double = 1.1, repeatLastN: Int = 64, penalizeNL: Bool = true, presencePenalty: Double = 0.0, frequencyPenalty: Double = 0.0, mirostat: Int = 0, mirostatTau: Double = 5.0, mirostatEta: Double = 0.1, grammar: String = "", seed: Int = -1, ignoreEOS: Bool = false, logitBias: [[Any]] = [], nProbs: Int = 0, imageData: [[String: Any]] = [], onSuccess:(@escaping (String)->()) = {_ in}) {
        
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
                let apiResponse = try JSONDecoder().decode(APIResponse.self, from: data)
                //let json = try JSONSerialization.jsonObject(with: data, options: [])
                print("Response JSON: \(apiResponse)")
                onSuccess(apiResponse.content)
                // Handle the JSON response here
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }

        task.resume()
    }
}
