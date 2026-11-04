.class public final Lorg/codehaus/stax2/ri/Stax2Util$TextBuffer;
.super Ljava/lang/Object;
.source "Stax2Util.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/codehaus/stax2/ri/Stax2Util;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "TextBuffer"
.end annotation


# instance fields
.field private mBuilder:Ljava/lang/StringBuffer;

.field private mText:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 117
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 110
    const/4 v0, 0x0

    iput-object v0, p0, Lorg/codehaus/stax2/ri/Stax2Util$TextBuffer;->mText:Ljava/lang/String;

    .line 115
    iput-object v0, p0, Lorg/codehaus/stax2/ri/Stax2Util$TextBuffer;->mBuilder:Ljava/lang/StringBuffer;

    .line 117
    return-void
.end method


# virtual methods
.method public append(Ljava/lang/String;)V
    .locals 3
    .param p1, "text"    # Ljava/lang/String;

    .line 127
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    .line 128
    .local v0, "len":I
    if-lez v0, :cond_2

    .line 130
    iget-object v1, p0, Lorg/codehaus/stax2/ri/Stax2Util$TextBuffer;->mText:Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 131
    new-instance v1, Ljava/lang/StringBuffer;

    iget-object v2, p0, Lorg/codehaus/stax2/ri/Stax2Util$TextBuffer;->mText:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    add-int/2addr v2, v0

    invoke-direct {v1, v2}, Ljava/lang/StringBuffer;-><init>(I)V

    iput-object v1, p0, Lorg/codehaus/stax2/ri/Stax2Util$TextBuffer;->mBuilder:Ljava/lang/StringBuffer;

    .line 132
    iget-object v1, p0, Lorg/codehaus/stax2/ri/Stax2Util$TextBuffer;->mBuilder:Ljava/lang/StringBuffer;

    iget-object v2, p0, Lorg/codehaus/stax2/ri/Stax2Util$TextBuffer;->mText:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 133
    const/4 v1, 0x0

    iput-object v1, p0, Lorg/codehaus/stax2/ri/Stax2Util$TextBuffer;->mText:Ljava/lang/String;

    .line 135
    :cond_0
    iget-object v1, p0, Lorg/codehaus/stax2/ri/Stax2Util$TextBuffer;->mBuilder:Ljava/lang/StringBuffer;

    if-eqz v1, :cond_1

    .line 136
    iget-object v1, p0, Lorg/codehaus/stax2/ri/Stax2Util$TextBuffer;->mBuilder:Ljava/lang/StringBuffer;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    goto :goto_0

    .line 138
    :cond_1
    iput-object p1, p0, Lorg/codehaus/stax2/ri/Stax2Util$TextBuffer;->mText:Ljava/lang/String;

    .line 141
    :cond_2
    :goto_0
    return-void
.end method

.method public get()Ljava/lang/String;
    .locals 1

    .line 145
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2Util$TextBuffer;->mText:Ljava/lang/String;

    if-eqz v0, :cond_0

    .line 146
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2Util$TextBuffer;->mText:Ljava/lang/String;

    return-object v0

    .line 148
    :cond_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2Util$TextBuffer;->mBuilder:Ljava/lang/StringBuffer;

    if-eqz v0, :cond_1

    .line 149
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2Util$TextBuffer;->mBuilder:Ljava/lang/StringBuffer;

    invoke-virtual {v0}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 151
    :cond_1
    const-string v0, ""

    return-object v0
.end method

.method public isEmpty()Z
    .locals 1

    .line 154
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2Util$TextBuffer;->mText:Ljava/lang/String;

    if-nez v0, :cond_0

    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2Util$TextBuffer;->mBuilder:Ljava/lang/StringBuffer;

    if-nez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public reset()V
    .locals 1

    .line 121
    const/4 v0, 0x0

    iput-object v0, p0, Lorg/codehaus/stax2/ri/Stax2Util$TextBuffer;->mText:Ljava/lang/String;

    .line 122
    iput-object v0, p0, Lorg/codehaus/stax2/ri/Stax2Util$TextBuffer;->mBuilder:Ljava/lang/StringBuffer;

    .line 123
    return-void
.end method
