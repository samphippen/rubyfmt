use crate::line_tokens::{Comment, LineToken};

pub struct CommentBlock {
    comments: Vec<String>,
}

impl CommentBlock {
    pub fn new(comments: Vec<String>) -> Self {
        CommentBlock { comments: comments }
    }

    pub fn to_line_tokens(self) -> Vec<Box<dyn LineToken>> {
        self.comments.into_iter().map(|v| Box::new(Comment::new(v)) as Box<dyn LineToken>).collect()
    }

    pub fn has_comments(&self) -> bool {
        self.comments.len() > 0
    }

    pub fn merge(&mut self, mut other: CommentBlock) {
        self.comments.append(&mut other.comments);
    }
}
