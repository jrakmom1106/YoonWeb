<%@ page import="java.util.Properties" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="java.io.*" %>

<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.BufferedInputStream"%>
<%@ page import="java.io.FileInputStream"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.FileNotFoundException"%>
<%@ page import="java.util.Enumeration"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="javax.servlet.ServletOutputStream"%>


<%
    Properties propertise = new Properties();
    try{
        propertise.load(getClass().getResourceAsStream("/config/common.propertise"));
    }catch (FileNotFoundException e){

    }catch (IOException e){

    }catch (Exception e){

    }

    String Prop = "common.file.path";
    String savePath = propertise.getProperty(Prop);
    String saveFile = request.getParameter("file");

    if(saveFile !=null && ! "".equals(saveFile)){
        saveFile = saveFile.replaceAll("/","");
        saveFile = saveFile.replaceAll("\\\\","");
        saveFile = saveFile.replaceAll("&","");
        saveFile = saveFile.replaceAll("\\.","");
        saveFile = saveFile.replaceAll("<","");
        saveFile = saveFile.replaceAll(">","");
        saveFile = saveFile.replaceAll("\"","");

    }


    String usrFile = request.getParameter("userfile");
    String fileType = request.getParameter("fileType");
    String pfilePath = request.getParameter("filePath");
    String tmpNm = new String(saveFile.getBytes("iso8859-1"), "UTF-8");
    String fileNm = tmpNm.replaceAll("\r","").replaceAll("\n","").replaceAll("<","").replaceAll(">","").replaceAll("\"","").replaceAll("&","");

    if(usrFile!=null && !"".equals(usrFile)) {
        String conVertNm = URLEncoder.encode(usrFile, "EUC-KR");
        String usrFileKr = new String(usrFile.getBytes("iso8859-1"), "EUC-KR");
        System.out.println("### usrFile: " + usrFile + ", conVertNm: " + conVertNm);
        //한글 포함시 URLEncoder.encode 로 인코딩
        if (usrFile.matches(".*[ㄱ-ㅎ ㅏ-ㅣ가-힣]+.*") || usrFileKr.matches(".*[ㄱ-ㅎ ㅏ-ㅣ가-힣]+.*")) {
            System.out.println("###(2)#### usrFileKr: " + usrFileKr + ", usrFileKr: " + usrFile);
            if (usrFileKr.matches(".*[ㄱ-ㅎ ㅏ-ㅣ가-힣]+.*")) {
                usrFile = new String(usrFile.getBytes("iso8859-1"), "EUC-KR");
            }
        } else {
            usrFile = new String(usrFile.getBytes("iso8859-1"), "UTF-8");
            System.out.println("#### (3) #### usrFile : " + usrFile);
        }

        usrFile = URLEncoder.encode(usrFile, "UTF-8");


        if (fileType != null && !"".equals(fileType)) {
            if ("test".equals(fileType)) {
                savePath = savePath + "/test";
            }
        }
    }

    byte[] buffer = new byte[1024];

    ServletOutputStream out_stream = null;
    BufferedInputStream in_stream = null;
    FileInputStream file_ins = null;

    File fis = new File(savePath + "/"+ fileNm);
    if(fis.exists()){
        try{
            //사용자 검증 하여도 됌

            String hostNm = request.getServerName();
            Enumeration<?> headerNames = request.getHeaderNames();
            String key = new String();
            boolean blnHeaderNames = headerNames.hasMoreElements();
            while( blnHeaderNames ){
                key = (String)headerNames.nextElement();
                if(key.equalsIgnoreCase("Host") ) {
                    String sValue = request.getHeader(key);
                    if(session.getId()==null || sValue==null || sValue.indexOf(hostNm)<0){
                        response.sendRedirect("UNAUTHORIZED");
                        return;
                    }
                }
                blnHeaderNames = headerNames.hasMoreElements();
            }


            response.reset();
            response.setCharacterEncoding("utf-8");
            response.setContentType("application/octet;charset=utf-8");
            if(usrFile ==null || "".equals(usrFile)){
                response.setHeader("Content-Disposition", "attachment;filename=\"" + fileNm + "\";");
            }else{
                response.setHeader("Content-Disposition", "attachment;filename=\"" + usrFile + "\";");
            }
            out.clear();
            out= pageContext.pushBody();

            out_stream = response.getOutputStream();
            file_ins = new FileInputStream(fis);
            in_stream = new BufferedInputStream(file_ins);

            int n = 0;
            while((n = in_stream.read(buffer, 0, 1024)) != -1){
                out_stream.write(buffer, 0, n);
            }

        }catch (IOException e){
            response.sendRedirect("IOException");
        }catch (Exception e){
            response.sendRedirect("E");
        }
        finally {
            if(in_stream != null) in_stream.close();
            if(out_stream != null) out_stream.close();
            if(file_ins != null) file_ins.close();
        }
    }else{
        response.sendRedirect("unknownfile");
    }


%>