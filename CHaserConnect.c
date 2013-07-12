/****************************
* 
*****************************/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <inttypes.h>
#include <netdb.h>

#define BUFSIZE 15

struct sockaddr_in server;
char   buf[BUFSIZE];
int    n;
int    sct;
char   hostadd[16];
struct hostent *host;
char   hostport[6];

