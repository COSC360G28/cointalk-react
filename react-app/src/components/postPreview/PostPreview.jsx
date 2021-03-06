import React from "react";
import "./styles.scss";
import { ReactComponent as UserIcon } from "../../assets/user.svg";
import { Stars } from "../stars/Stars";

export const PostPreview = ({
  pid,
  title,
  image,
  text,
  username,
  score,
  liked,
}) => {
  const goToPost = () => {
    window.location.href = `/post/${pid}`;
  };

  return (
    <div className="post-preview">
      {image ? (
        <img
          onClick={goToPost}
          className="post-preview-image"
          src={process.env.REACT_APP_API_URL + "/image/" + image}
          alt="Post"
        />
      ) : null}
      <div className="post-preview-text-container">
        <div className="post-preview-header">
          <div className="post-preview-info-container">
            <h3 onClick={goToPost} className="post-preview-title">
              {title}
            </h3>
            <a href={`/user/${username}`} className="user-container">
              <UserIcon className="user-icon" />
              <p>{username}</p>
            </a>
          </div>
          <Stars score={score} postId={pid} />
        </div>
        <p className="post-preview-text">{text}</p>
      </div>
    </div>
  );
};
