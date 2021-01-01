package exception;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Exception sévère (SQL, Servlet, IO)
 * @author Raphaël Kimm
 *
 */
public class SevereAppException extends AppException {

	private static final long serialVersionUID = 1L;

	public SevereAppException(Throwable t, HttpServletRequest request, HttpServletResponse response)  {
		super(ERROR, t, request, response);
	}
	
	public SevereAppException(String s, HttpServletRequest request, HttpServletResponse response)  {
		super(ERROR, s, request, response);
	}
}
