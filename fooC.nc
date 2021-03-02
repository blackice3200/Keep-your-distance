
#include "Timer.h"
#include "foo.h"
 

module fooC @safe() {
  uses {
    //interface Leds;
    interface Boot;
    interface Receive;
    interface AMSend;
    interface Timer<TMilli> as MilliTimer;
    interface SplitControl as AMControl;
    interface Packet;
   	//interface Random;
   	//interface LogRead;
    //interface LogWrite;
  }
}
implementation {

  message_t packet;

  //bool locked;
  /*
  typedef nx_struct logentry_t {
    nx_uint8_t len;
    message_t msg;
  } logentry_t;

  logentry_t m_entry;
*/  
  event void Boot.booted() {
    call AMControl.start();
  }

  event void AMControl.startDone(error_t err) {
    if (err == SUCCESS) {
    	
    	
    	    call MilliTimer.startPeriodic(500); 	
    	

    }
    else {
      call AMControl.start();
    }
  }

  event void AMControl.stopDone(error_t err) {
    // do nothing
  }
  
  event void MilliTimer.fired() {
    


      my_packet_t* rcm = (my_packet_t*)call Packet.getPayload(&packet, sizeof(my_packet_t));
      
if (rcm == NULL) {
		return;
      }

      rcm->node_id = TOS_NODE_ID;
     
      	
      
      call AMSend.send(AM_BROADCAST_ADDR, &packet, sizeof(my_packet_t)) ;
    
  }
  
 /* 
 event void LogWrite.eraseDone(error_t err) { }
 event void LogRead.readDone(void* buf, storage_len_t len, error_t err) {}
 event void LogWrite.appendDone(void* buf, storage_len_t len,bool recordsLost, error_t err) {}
 event void LogRead.seekDone(error_t err) { }

 event void LogWrite.syncDone(error_t err) { } 
  */
  

  event message_t* Receive.receive(message_t* bufPtr, 
				   void* payload, uint8_t len) {


//if (call LogWrite.append(&m_entry, sizeof(logentry_t)) != SUCCESS) {}
      
    if (len != sizeof(my_packet_t)) {return bufPtr;}
    else {
      my_packet_t* rcm = (my_packet_t*)payload;
      

      	printf("\n{'s':'%u','r':'%u'}\n",rcm->node_id,TOS_NODE_ID);
     	printfflush();
     
     

  	
      return bufPtr;
    }
  }

  event void AMSend.sendDone(message_t* bufPtr, error_t error) {
    //if (&packet == bufPtr) {
      //locked = FALSE;
    //}
  }


                               
                                
 
 

}




