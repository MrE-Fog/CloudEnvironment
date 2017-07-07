/*
 * Copyright IBM Corporation 2017
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import XCTest
import Configuration
@testable import Credentials
@testable import CloudEnvironment

class PushSDKTests: XCTestCase {

    static var allTests : [(String, (PushSDKTests) -> () throws -> Void)] {
        return [
            ("testGetCredentials", testGetCredentials),
        ]
    }

    func testGetCredentials() {

        // Load test mappings.json file and Cloud Foundry test credentials-- VCAP_SERVICES and VCAP_APPLICATION
        let cloudEnv = CloudEnv(mappingsFilePath: "Tests/CredentialsTests/resources", cloudFoundryFile: "Tests/CredentialsTests/resources/config_cf_example.json")

        guard let credentials =  cloudEnv.getPushSDKCredentials(name: "PushNotificationKey") else {
            XCTFail("Could not load Push SDK credentials.")
            return
        }

        XCTAssertEqual(credentials.appGuid, "push-appGuid", "PushSDK service appGuid should match.")
        XCTAssertEqual(credentials.url, "http://imfpush.ng.bluemix.net/imfpush/v1", "PushSDK service url should match.")
        XCTAssertEqual(credentials.admin_url, "//mobile.ng.bluemix.net/imfpushdashboard", "PushSDK service admin_url should match.")
        XCTAssertEqual(credentials.appSecret, "push-secret", "PushSDK service appSecret should match.")
        XCTAssertEqual(credentials.clientSecret, "push-clientSecret", "PushSDK service clientSecret should match.")

    }

}