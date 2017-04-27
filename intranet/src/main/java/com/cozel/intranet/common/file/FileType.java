package com.cozel.intranet.common.file;

public enum FileType {
   USR("1"),                      //후보자 
   BOARD("2"),                   //게시판
   SCHEDULE("3"),              //스케줄
   CONSULTANT("4");          //컨설턴트
    
   private String code;
   
   FileType(String code) {
       this.code = code;
   }
   
   public String getCode() {
       return this.code;
   }
   
}
