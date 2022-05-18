package com.yoon.controller.download;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

@Controller
public class FileDownController {

    @RequestMapping("fileDownload.do")
    public void fileDownload(HttpServletRequest request, HttpServletResponse response) throws Exception {
        //String path =  request.getSession().getServletContext().getRealPath("저장경로");

        String filename =request.getParameter("fileName");
        String realname = request.getParameter("filerealName");
        System.out.println("hhhhhh");
        System.out.println("realname = " + realname);

        String realFilename="";
        System.out.println(filename);


        if(realname!=null && !"".equals(realname)) { // 파일 다운로드시 한국어로 인코딩해서 사용자에게 보여주는 코드
            String conVertNm = URLEncoder.encode(realname, "EUC-KR");
            String realnameKr = new String(realname.getBytes("iso8859-1"), "EUC-KR");
            System.out.println("### realname: " + realname + ", conVertNm: " + conVertNm);
            //한글 포함시 URLEncoder.encode 로 인코딩
            if (realname.matches(".*[ㄱ-ㅎ ㅏ-ㅣ가-힣]+.*") || realnameKr.matches(".*[ㄱ-ㅎ ㅏ-ㅣ가-힣]+.*")) {
                System.out.println("###(2)#### realnameKr: " + realnameKr + ", realnameKr: " + realname);
                if (realnameKr.matches(".*[ㄱ-ㅎ ㅏ-ㅣ가-힣]+.*")) {
                    realname = new String(realname.getBytes("iso8859-1"), "EUC-KR");
                }
            } else {
                realname = new String(realname.getBytes("iso8859-1"), "UTF-8");
                System.out.println("#### (3) #### realname : " + realname);
            }

            realname = URLEncoder.encode(realname, "UTF-8");

        }

        try {
            String browser = request.getHeader("User-Agent");
            //파일 인코딩
            if (browser.contains("MSIE") || browser.contains("Trident")
                    || browser.contains("Chrome")) {
                filename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+",
                        "%20");
            } else {
                filename = new String(filename.getBytes("UTF-8"), "ISO-8859-1");
            }
        } catch (UnsupportedEncodingException ex) {
            System.out.println("UnsupportedEncodingException");
        }

        realFilename = "C:\\filetest\\" + filename;
        System.out.println(realFilename);
        File file1 = new File(realFilename);
        if (!file1.exists()) {
            return ;
        }

        Long fileLength = file1.length();

        //파일명 한글시 인코딩.
        response.setCharacterEncoding("utf-8");



        // 파일명 지정

        response.setContentType("application/octer-stream;charset=utf-8");
        response.setHeader("Content-Transfer-Encoding", "binary;");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + realname + "\"");

        response.setHeader("Content-Length",""+fileLength);
        response.setHeader("Pragma", "no-cache;");
        response.setHeader("Expires", "-1;");


        try {
            OutputStream os = response.getOutputStream();
            FileInputStream fis = new FileInputStream(realFilename);

            int ncount = 0;
            byte[] bytes = new byte[512];

            while ((ncount = fis.read(bytes)) != -1 ) {
                os.write(bytes, 0, ncount);
            }
            fis.close();
            os.close();
        } catch (Exception e) {
            System.out.println("FileNotFoundException : " + e);
        }
    }
}
