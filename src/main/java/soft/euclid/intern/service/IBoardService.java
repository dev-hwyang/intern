package soft.euclid.intern.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import soft.euclid.intern.ServiceResult;
import soft.euclid.intern.vo.BoardVO;
import soft.euclid.intern.vo.CommentVO;
import soft.euclid.intern.vo.FileVO;
import soft.euclid.intern.vo.SearchVO;

public interface IBoardService {

	public ServiceResult register(HttpServletRequest req, BoardVO boardVO);

	public BoardVO select(int boNo);

	public ServiceResult update(HttpServletRequest req, BoardVO boardVO);

	public ServiceResult delete(int boNo);

	public List<BoardVO> searchlist(SearchVO<BoardVO> sVO);

	public FileVO fileDownload(int fileNo);

	public List<BoardVO> mylist(SearchVO<BoardVO> sVO);

	public ServiceResult registerComment(HttpServletRequest req, CommentVO commentVO);

	public ServiceResult deleteComment(int coNo);

}
