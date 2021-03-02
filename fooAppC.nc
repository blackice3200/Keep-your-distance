
#include "foo.h"
#define NEW_PRINTF_SEMANTICS
#include "printf.h"
//#include "StorageVolumes.h"

configuration fooAppC {}
implementation {
  components MainC, fooC as App;
  components new AMSenderC(AM_RADIO_COUNT_MSG);
  components new AMReceiverC(AM_RADIO_COUNT_MSG);
  components new TimerMilliC();
  components ActiveMessageC;
  
 // components RandomC;
  
 //components new LogStorageC(VOLUME_LOGTEST, TRUE);
 //App.LogRead -> LogStorageC;
 //App.LogWrite -> LogStorageC;
  
  components PrintfC;
  components SerialStartC;
  
  App.Boot -> MainC.Boot;
  
  App.Receive -> AMReceiverC;
  App.AMSend -> AMSenderC;
  App.AMControl -> ActiveMessageC;
  //App.Leds -> LedsC;
  App.MilliTimer -> TimerMilliC;
  App.Packet -> AMSenderC;
  //App.Random -> RandomC;
  //RandomC <- MainC.SoftwareInit;
}


