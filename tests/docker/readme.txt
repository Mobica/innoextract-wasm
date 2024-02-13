How to run test on a local machine
1. Install docker. For the instructions please visit docker.com
2. Download repo
3. Set your directory to ../tests/docker/
4. Build image using Dockerfile
    docker build -t innoextract-tests .
    # First build take some time
5. Run container
    docker run -p 5999:5999 -v ${PWD}:/artifacts innoextract-test
6. In order to see running test use VNC client and connect to localhost:5999. Password: innoextract.
7. Test result can be found in ${PWD}/output
