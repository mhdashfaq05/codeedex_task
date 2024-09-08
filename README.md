# codeedex_task

Synopsis of the CodeeDex Task Application:

Framework: Flutter for developing mobile apps on several platforms.
Authentication: Token-based session management and OTP-based login mechanism for safe access.
API Integration: Using external APIs for user authentication and task management (CRUD operations).
Important characteristics:
1. Authentication with OTP:
User Registration/Login:
Users use their email address or mobile number to register or log in.
A One-Time Password (OTP) is sent to the user's email address or phone number in response to an API call.
OTP Verification: After users input their OTP, the application calls an API to confirm it.
The server provides a token after verification in order to authenticate additional actions.
Safe Authentication: By eliminating the need for passwords, OTP-based login guarantees convenient and safe authentication, enhancing user experience.

2. JWT Tokens for Token-Based Session Management
The server generates a JWT (JSON Web Token) upon successful OTP verification. This token is provided to the application and used for authenticating further API requests.
Session Persistence: The application uses secure storage, such as flutter_secure_storage, or SharedPreferences to save the token locally. When the program launches again, it checks the token and restores the session without requesting a login if it is valid.
Token Expiration & Refresh: If a token expires, users are either redirected to log in again or the token is refreshed.

3. Task Management via API:
CRUD Operations:
Users can manage tasks by creating, reading, updating, or deleting tasks. API calls handle all interactions with the server to keep tasks synchronized.
Real-Time Sync:
Task-related actions are instantly synced with the backend using API requests, ensuring up-to-date task data across 

4. Token Workflow and OTP:
OTP Request: First, users input their email address or phone number. To generate and send an OTP, the app makes a request to the backend.
OTP Verification: After users input their OTP, the code is verified by an API request. If accurate, a JWT token is returned by the server.
Token Storage: Packages like flutter_secure_storage and SharedPreferences are used by the application to safely store the token.
Authenticated queries: The token for safe backend communication is included in any ensuing API queries (such as those for retrieving or changing tasks).


Security Considerations:
Secure Token Storage: Flutter packages like flutter_secure_storage and SharedPreferences are used to store tokens safely and guard against illegal access.
Handling Token Expiration: If the backend allows it, the app will handle token expiration and notify users to re-authenticate or refresh the token.
API Security: To provide safe communication and stop unwanted data access, every API request is authenticated using the token.
Advantages of Token-Based Authentication with OTP:
Enhanced Security: OTP makes sure the app can only be accessed by those who are allowed. Session tokens aid in preventing unwanted access to user information.
User Convenience: Tokens enable users to stay logged in during sessions, while OTP login removes the need for password memory.

Seamless Task Management:
Task management that is seamless is made possible by the safe execution of all tasks and their real-time synchronization with the backend, which guarantees task accessibility across devices.

Screenshots: https://drive.google.com/drive/folders/1-78QKCqW0QgZHvfPWUv6tsWRUPmXUUnr?usp=drive_link
Apk Link: https://drive.google.com/drive/folders/19w4eYr_YYDKP_9wrpNYP0OJ-Z73Z-pLp?usp=drive_link
