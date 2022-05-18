package com.yoon.service;


import com.yoon.mapper.BoardMapper;
import com.yoon.model.BoardVO;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.io.File;
import java.io.IOException;
import java.util.*;

@Service
public class BoardServiceImpl implements BoardService{

    @Autowired
    BoardMapper boardmapper;

    @Override
    public List<BoardVO> boardSearch(Integer start, Integer last, String writer, String title) throws Exception {
        return boardmapper.boardSearch(start,last,writer,title);
    }

    @Override
    public void boardWrite(Map<String, Object> param) throws Exception {
        boardmapper.boardWrite(param);

        if(param.containsKey("filelist")){
            List<MultipartFile> list = (List<MultipartFile>) param.get("filelist");

            System.out.println("list = " + list);

            String savepath = "C:\\filetest\\";

                for(int i =0 ; i < list.size(); i++){
                    MultipartFile mf = list.get(i);
                    UUID uuid = UUID.randomUUID();
                    String origin = mf.getOriginalFilename();
                    //확장자
                    String ext = FilenameUtils.getExtension(origin);
                    String savename = uuid +"." + ext;


                    File file = new File(savepath,savename);
                    param.put("file_name",savename);
                    param.put("real_name",origin);
                    boardmapper.insertfile(param);
                }


        }
    }

    @Override
    public int serchbno() throws Exception {
        return boardmapper.searchbno();
    }
    @Override
    public int searchcnt(String writer , String title) throws Exception{
        return boardmapper.searchcnt(writer,title);
    }

    @Override
    public List<BoardVO> selectBoard(Integer bno){
        return boardmapper.selectBoard(bno);
    }

    @Override
    public void boardRemove(Integer bno){ boardmapper.boardRemove(bno);}

    @Override
    public void boardUpdate(String title, String content, Integer bno){ boardmapper.boardUpdate(title,content,bno);}

    @Override
    public Map<String, String> createfileList(MultipartHttpServletRequest req) throws IOException {

        System.out.println("--게시글 등록을 위한 데이터 변환 처리 시작--");

        System.out.println("req = " + req);
        String files = req.getParameter("files");
        System.out.println("files = " + files);
        String title = req.getParameter("subject");
        System.out.println("title = " + title);
        String content = req.getParameter("content");
        System.out.println("content = " + content);
        String writer = req.getParameter("writer");
        System.out.println("writer = " + writer);
        String date = req.getParameter("date");
        System.out.println("date = " + date);

        List<MultipartFile> file = req.getFiles("filename");
        System.out.println("file =" + file);
        String filename = "";



        ArrayList<String> filenamelist = new ArrayList<String>();
        ArrayList<String> filerealnamelist = new ArrayList<String>();
        Map<String, String> result = new HashMap<String,String>();

        // file 첨부여부 확인
        if (!file.get(0).getOriginalFilename().isEmpty()) {

            System.out.println("비어있지 않음");

            for (int i = 0; i < file.size(); i++) {

                //원래이름 저장

                String originname = file.get(i).getOriginalFilename();
                System.out.println("originname = " + originname);

                //확장자
                String ext = FilenameUtils.getExtension(originname);
                System.out.println("ext = " + ext);
                //중복방지를 위한 UUID 설정
                UUID uuid = UUID.randomUUID();
                //저장되는 파일이름
                filename = uuid + "." + ext;

                file.get(i).transferTo(new File("C:\\filetest\\" + filename));


                filenamelist.add(filename);
                filerealnamelist.add(originname);

                System.out.println("filenamelist = " + filenamelist);
                System.out.println("filenamelist.toString() = " + filenamelist.toString());

            }
        }

        result.put("title",title);
        result.put("content",content);
        result.put("writer",writer);
        result.put("date",date);
        result.put("filelist",filenamelist.toString());
        result.put("filerealname",filerealnamelist.toString());


        return result;
    }

    @Override
    public Map<String, Object> boardDetail(Map<String, Object> param) {
        Map<String, Object> result = boardmapper.boardDetail(param);

        return result;
    }
}
