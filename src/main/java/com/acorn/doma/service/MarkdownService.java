package com.acorn.doma.service;

import org.commonmark.node.Node;
import org.commonmark.parser.Parser;
import org.commonmark.renderer.html.HtmlRenderer;
import org.springframework.stereotype.Service;

import com.acorn.doma.cmn.PLog;

@Service
public class MarkdownService implements PLog {
	
	public MarkdownService() {
		log.debug("┌───────────────────────────┐");
		log.debug("│ Markdown()                │");
		log.debug("└───────────────────────────┘");
		
	}
	
	public static String convertMarkdownToHtml(String markdown) {
		Parser parser = Parser.builder().build();
		Node document = parser.parse(markdown);
		
		HtmlRenderer renderer = HtmlRenderer.builder().build();
		
		String html = renderer.render(document);
		log.debug("┌───────────────────────────┐");
		log.debug("│ html()                    │\n" + html);
		log.debug("└───────────────────────────┘");
		
		return html;
	}

}
