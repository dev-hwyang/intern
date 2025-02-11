package soft.euclid.intern.mapper;

import java.util.List;

import soft.euclid.intern.ServiceResult;
import soft.euclid.intern.vo.BoardVO;
import soft.euclid.intern.vo.CommentVO;
import soft.euclid.intern.vo.FileVO;
import soft.euclid.intern.vo.MemberVO;
import soft.euclid.intern.vo.SearchVO;

public interface BoardMapper {

	public int insert(BoardVO boardVO);
	
	public void insertFile(FileVO fileVO);

	public BoardVO selectBoard(int boNo);

	public int update(BoardVO boardVO);

	public int delete(int boNo);

	public List<BoardVO> searchlist(SearchVO<BoardVO> sVO);

	public MemberVO readByUserId(String username);

	public List<FileVO> selectFile(int boNo);

	public int howManyFile(int boNo);

	public void fileDelete(Integer integer);

	public FileVO fileDownload(int fileNo);

	public List<BoardVO> myList(SearchVO<BoardVO> sVO);

	public FileVO selectFileDelete(Integer integer);

	public void deleteFilesWithBoard(int boNo);

	public void increamentHit(int boNo);

	public int registerComment(CommentVO commentVO);

	public List<CommentVO> selectComment(int boNo);

	public int deleteComment(int coNo);

	public void deleteCommentsWithBoard(int boNo);

}
