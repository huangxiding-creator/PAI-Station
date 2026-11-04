.class public Lorg/codehaus/stax2/ri/evt/CommentEventImpl;
.super Lorg/codehaus/stax2/ri/evt/BaseEventImpl;
.source "CommentEventImpl.java"

# interfaces
.implements Ljavax/xml/stream/events/Comment;


# instance fields
.field final mContent:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljavax/xml/stream/Location;Ljava/lang/String;)V
    .locals 0
    .param p1, "loc"    # Ljavax/xml/stream/Location;
    .param p2, "content"    # Ljava/lang/String;

    .line 19
    invoke-direct {p0, p1}, Lorg/codehaus/stax2/ri/evt/BaseEventImpl;-><init>(Ljavax/xml/stream/Location;)V

    .line 20
    iput-object p2, p0, Lorg/codehaus/stax2/ri/evt/CommentEventImpl;->mContent:Ljava/lang/String;

    .line 21
    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 3
    .param p1, "o"    # Ljava/lang/Object;

    .line 67
    if-ne p1, p0, :cond_0

    const/4 v0, 0x1

    return v0

    .line 68
    :cond_0
    const/4 v0, 0x0

    if-nez p1, :cond_1

    return v0

    .line 69
    :cond_1
    instance-of v1, p1, Ljavax/xml/stream/events/Comment;

    if-nez v1, :cond_2

    return v0

    .line 71
    :cond_2
    move-object v0, p1

    check-cast v0, Ljavax/xml/stream/events/Comment;

    .line 72
    .local v0, "other":Ljavax/xml/stream/events/Comment;
    iget-object v1, p0, Lorg/codehaus/stax2/ri/evt/CommentEventImpl;->mContent:Ljava/lang/String;

    invoke-interface {v0}, Ljavax/xml/stream/events/Comment;->getText()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    return v1
.end method

.method public getEventType()I
    .locals 1

    .line 37
    const/4 v0, 0x5

    return v0
.end method

.method public getText()Ljava/lang/String;
    .locals 1

    .line 26
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/CommentEventImpl;->mContent:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 1

    .line 77
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/CommentEventImpl;->mContent:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->hashCode()I

    move-result v0

    return v0
.end method

.method public writeAsEncodedUnicode(Ljava/io/Writer;)V
    .locals 1
    .param p1, "w"    # Ljava/io/Writer;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 44
    :try_start_0
    const-string v0, "<!--"

    invoke-virtual {p1, v0}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    .line 45
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/CommentEventImpl;->mContent:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    .line 46
    const-string v0, "-->"

    invoke-virtual {p1, v0}, Ljava/io/Writer;->write(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 49
    goto :goto_0

    .line 47
    :catch_0
    move-exception v0

    .line 48
    .local v0, "ie":Ljava/io/IOException;
    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/evt/CommentEventImpl;->throwFromIOE(Ljava/io/IOException;)V

    .line 50
    .end local v0    # "ie":Ljava/io/IOException;
    :goto_0
    return-void
.end method

.method public writeUsing(Lorg/codehaus/stax2/XMLStreamWriter2;)V
    .locals 1
    .param p1, "w"    # Lorg/codehaus/stax2/XMLStreamWriter2;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 55
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/CommentEventImpl;->mContent:Ljava/lang/String;

    invoke-interface {p1, v0}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeComment(Ljava/lang/String;)V

    .line 56
    return-void
.end method
