package com.cozel.intranet.common.utils;

import java.text.DecimalFormat;

public class StringUtil {
	
	public static String NVL(Object obj) {
        return (obj == null) ? "" : obj.toString().trim();
    }

    public static String NVL(Object obj, String str) {
        return (obj == null) ? str : obj.toString().trim();
    }

    public static String NVL(String str) {
        return NVL(str, "");
    }
    
    // String이 비었거나("") 혹은 null 인지 검증한다.
    // str - 체크 대상 스트링오브젝트이며 null을 허용함
    public static boolean isEmpty(String str) {
        return str == null || str.length() == 0;
    }
    
    // 문자열이 지정한 길이를 초과했을때 지정한길이에다가 해당 문자열을 붙여주는 메서드.
    public static String cutString(String source, String output, int slength) {
        String returnVal = null;
        if (source != null) {
            if (source.length() > slength) {
                returnVal = source.substring(0, slength) + output;
            } else
                returnVal = source;
        }
        return returnVal;
    }
    
    // 문자열이 지정한 길이를 초과했을때 해당 문자열을 삭제하는 메서드
    public static String cutString(String source, int slength) {
        String result = null;
        if (source != null) {
            if (source.length() > slength) {
                result = source.substring(0, slength);
            } else
                result = source;
        }
        return result;
    }
    
    // 문자열의 3자리마다 콤마(,) 찍기 메서드.
    public static String toCommifyString(String sourceNum) {
        if (sourceNum.isEmpty()) return "";
        if (sourceNum.length() <= 3) return sourceNum;
        double num = Double.parseDouble(sourceNum);
        DecimalFormat df = new DecimalFormat("#,###");
        return df.format(num).toString();
    }
    
    // 기준 문자열에 포함된 모든 대상 문자(char)를 제거한다.
    // 제거대상 문자열이 제거된 입력문자열. 입력문자열이 null인 경우 출력문자열은 null
    public static String remove(String str, char remove) {
        if (isEmpty(str) || str.indexOf(remove) == -1) {
            return str;
        }
        char[] chars = str.toCharArray();
        int pos = 0;
        for (int i = 0; i < chars.length; i++) {
            if (chars[i] != remove) {
                chars[pos++] = chars[i];
            }
        }
        return new String(chars, 0, pos);
    }
    
    // 문자열 내부의 콤마 character(,)를 모두 제거한다.
    public static String removeCommaChar(String str) {
        return remove(str, ',');
    }

    // 문자열 내부의 마이너스 character(-)를 모두 제거한다.
    public static String removeMinusChar(String str) {
        return remove(str, '-');
    }
    
    // Html 코드가 들어간 문서를 표시할때 태그에 손상없이 보이기 위한 메서드
    // HTML 태그를 치환한 문자열
    public static String checkHtmlView(String strString) {
        String strNew = "";
        try {
            StringBuffer strTxt = new StringBuffer("");
            char chrBuff;
            int len = strString.length();
            for (int i = 0; i < len; i++) {
                chrBuff = (char) strString.charAt(i);
                switch (chrBuff) {
                    case '<':
                        strTxt.append("&lt;");
                        break;
                    case '>':
                        strTxt.append("&gt;");
                        break;
                    case '"':
                        strTxt.append("&quot;");
                        break;
                    case 10:
                        strTxt.append("<br>");
                        break;
                    case ' ':
                        strTxt.append("&nbsp;");
                        break;
                    //case '&' :
                    //strTxt.append("&amp;");
                    //break;
                    default:
                        strTxt.append(chrBuff);
                }
            }
            strNew = strTxt.toString();
        } catch (Exception ex) {
            return null;
        }
        return strNew;
    }
    
    // HTML특수문자를 비지니스 로직에서 처리하기위헤 변환('&amp' -> '&')하는 기능이다
    public static String toTEXT(String str) {
        if (str == null)
            return null;
        String returnStr = str;
        returnStr = returnStr.replaceAll("<br>", "\n");
        returnStr = returnStr.replaceAll("&gt;", ">");
        returnStr = returnStr.replaceAll("&lt;", "<");
        returnStr = returnStr.replaceAll("&quot;", "\"");
        returnStr = returnStr.replaceAll("&nbsp;", " ");
        returnStr = returnStr.replaceAll("&amp;", "&");
        returnStr = returnStr.replaceAll("\"", "&#34;");
        // returnStr = returnStr.replaceAll("&#34;", "\"");
        return returnStr;
    }
    
    // {@link String#toLowerCase()}를 이용하여 소문자로 변환한다.
    // 소문자로 변환된 문자열, null이 입력되면 null 리턴
    public static String lowerCase(String str) {
        if (str == null) {
            return null;
        }
        return str.toLowerCase();
    }

    // {@link String#toUpperCase()}를 이용하여 대문자로 변환한다.
    // 대문자로 변환된 문자열, null이 입력되면 <code>null</code> 리턴
    public static String upperCase(String str) {
        if (str == null) {
            return null;
        }
        return str.toUpperCase();
    }
    
    // textArea 에서 \r\n(엔터)값을 <br/>태그로 치환
    public static String replaceTagToBr(String param) {
        try {
            if (param != null) {
                param = checkHtmlView(param);    //태그치환
                param = param.replace("\r\n", "<br/>");    //엔터치환
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return param;
    }
    
    //textArea 에서 <br/>태그를 \r\n(엔터)값으로 치환
    public static String replaceBrToTag(String param) {
        try {
            if (param != null) {
                param = param.replace("<br/>", "\r\n");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return param;
    }
    
    //String에 preFix 추가 (자리수 고정용)
	public static String setPrefixLen(String asVal, int ailen,String k) {
		try{
			String lsTemp = "";      
			byte [] tmpString = asVal.getBytes();
			
			if(ailen <= tmpString.length) 
				return asVal;

			for(int i = ailen - tmpString.length; i > 0 ; i--) {
				lsTemp += k;
			}
			return lsTemp + asVal;
		}
		catch(Exception e) {
			return asVal;
		}
	}
}
