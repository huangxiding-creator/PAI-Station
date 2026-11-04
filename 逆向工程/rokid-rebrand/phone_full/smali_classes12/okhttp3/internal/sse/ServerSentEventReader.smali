.class public final Lokhttp3/internal/sse/ServerSentEventReader;
.super Ljava/lang/Object;
.source "ServerSentEventReader.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lokhttp3/internal/sse/ServerSentEventReader$Callback;
    }
.end annotation


# static fields
.field private static final CRLF:Lokio/ByteString;

.field private static final DATA:Lokio/ByteString;

.field private static final EVENT:Lokio/ByteString;

.field private static final ID:Lokio/ByteString;

.field private static final RETRY:Lokio/ByteString;


# instance fields
.field private final callback:Lokhttp3/internal/sse/ServerSentEventReader$Callback;

.field private lastId:Ljava/lang/String;

.field private final source:Lokio/BufferedSource;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 25
    const-string v0, "\r\n"

    invoke-static {v0}, Lokio/ByteString;->encodeUtf8(Ljava/lang/String;)Lokio/ByteString;

    move-result-object v0

    sput-object v0, Lokhttp3/internal/sse/ServerSentEventReader;->CRLF:Lokio/ByteString;

    .line 26
    const-string v0, "data"

    invoke-static {v0}, Lokio/ByteString;->encodeUtf8(Ljava/lang/String;)Lokio/ByteString;

    move-result-object v0

    sput-object v0, Lokhttp3/internal/sse/ServerSentEventReader;->DATA:Lokio/ByteString;

    .line 27
    const-string v0, "id"

    invoke-static {v0}, Lokio/ByteString;->encodeUtf8(Ljava/lang/String;)Lokio/ByteString;

    move-result-object v0

    sput-object v0, Lokhttp3/internal/sse/ServerSentEventReader;->ID:Lokio/ByteString;

    .line 28
    const-string v0, "event"

    invoke-static {v0}, Lokio/ByteString;->encodeUtf8(Ljava/lang/String;)Lokio/ByteString;

    move-result-object v0

    sput-object v0, Lokhttp3/internal/sse/ServerSentEventReader;->EVENT:Lokio/ByteString;

    .line 29
    const-string v0, "retry"

    invoke-static {v0}, Lokio/ByteString;->encodeUtf8(Ljava/lang/String;)Lokio/ByteString;

    move-result-object v0

    sput-object v0, Lokhttp3/internal/sse/ServerSentEventReader;->RETRY:Lokio/ByteString;

    return-void
.end method

.method public constructor <init>(Lokio/BufferedSource;Lokhttp3/internal/sse/ServerSentEventReader$Callback;)V
    .locals 2
    .param p1, "source"    # Lokio/BufferedSource;
    .param p2, "callback"    # Lokhttp3/internal/sse/ServerSentEventReader$Callback;

    .line 41
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 39
    const/4 v0, 0x0

    iput-object v0, p0, Lokhttp3/internal/sse/ServerSentEventReader;->lastId:Ljava/lang/String;

    .line 42
    if-eqz p1, :cond_1

    .line 43
    if-eqz p2, :cond_0

    .line 44
    iput-object p1, p0, Lokhttp3/internal/sse/ServerSentEventReader;->source:Lokio/BufferedSource;

    .line 45
    iput-object p2, p0, Lokhttp3/internal/sse/ServerSentEventReader;->callback:Lokhttp3/internal/sse/ServerSentEventReader$Callback;

    .line 46
    return-void

    .line 43
    :cond_0
    new-instance v0, Ljava/lang/NullPointerException;

    const-string v1, "callback == null"

    invoke-direct {v0, v1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 42
    :cond_1
    new-instance v0, Ljava/lang/NullPointerException;

    const-string/jumbo v1, "source == null"

    invoke-direct {v0, v1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private completeEvent(Ljava/lang/String;Ljava/lang/String;Lokio/Buffer;)V
    .locals 4
    .param p1, "id"    # Ljava/lang/String;
    .param p2, "type"    # Ljava/lang/String;
    .param p3, "data"    # Lokio/Buffer;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 107
    invoke-direct {p0}, Lokhttp3/internal/sse/ServerSentEventReader;->skipCrAndOrLf()V

    .line 109
    invoke-virtual {p3}, Lokio/Buffer;->size()J

    move-result-wide v0

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-eqz v0, :cond_0

    .line 110
    iput-object p1, p0, Lokhttp3/internal/sse/ServerSentEventReader;->lastId:Ljava/lang/String;

    .line 111
    const-wide/16 v0, 0x1

    invoke-virtual {p3, v0, v1}, Lokio/Buffer;->skip(J)V

    .line 112
    iget-object v0, p0, Lokhttp3/internal/sse/ServerSentEventReader;->callback:Lokhttp3/internal/sse/ServerSentEventReader$Callback;

    invoke-virtual {p3}, Lokio/Buffer;->readUtf8()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, p1, p2, v1}, Lokhttp3/internal/sse/ServerSentEventReader$Callback;->onEvent(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 114
    :cond_0
    return-void
.end method

.method private isKey(Lokio/ByteString;)Z
    .locals 4
    .param p1, "key"    # Lokio/ByteString;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 164
    iget-object v0, p0, Lokhttp3/internal/sse/ServerSentEventReader;->source:Lokio/BufferedSource;

    const-wide/16 v1, 0x0

    invoke-interface {v0, v1, v2, p1}, Lokio/BufferedSource;->rangeEquals(JLokio/ByteString;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_2

    .line 165
    iget-object v0, p0, Lokhttp3/internal/sse/ServerSentEventReader;->source:Lokio/BufferedSource;

    invoke-interface {v0}, Lokio/BufferedSource;->buffer()Lokio/Buffer;

    move-result-object v0

    invoke-virtual {p1}, Lokio/ByteString;->size()I

    move-result v2

    int-to-long v2, v2

    invoke-virtual {v0, v2, v3}, Lokio/Buffer;->getByte(J)B

    move-result v0

    .line 166
    .local v0, "nextByte":B
    const/16 v2, 0x3a

    if-eq v0, v2, :cond_0

    const/16 v2, 0xd

    if-eq v0, v2, :cond_0

    const/16 v2, 0xa

    if-ne v0, v2, :cond_1

    :cond_0
    const/4 v1, 0x1

    :cond_1
    return v1

    .line 170
    .end local v0    # "nextByte":B
    :cond_2
    return v1
.end method

.method private parseData(Lokio/Buffer;J)V
    .locals 2
    .param p1, "data"    # Lokio/Buffer;
    .param p2, "end"    # J
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 117
    const/16 v0, 0xa

    invoke-virtual {p1, v0}, Lokio/Buffer;->writeByte(I)Lokio/Buffer;

    .line 118
    const-wide/16 v0, 0x4

    invoke-direct {p0, v0, v1}, Lokhttp3/internal/sse/ServerSentEventReader;->skipNameAndDivider(J)J

    move-result-wide v0

    sub-long/2addr p2, v0

    .line 119
    iget-object v0, p0, Lokhttp3/internal/sse/ServerSentEventReader;->source:Lokio/BufferedSource;

    invoke-interface {v0, p1, p2, p3}, Lokio/BufferedSource;->readFully(Lokio/Buffer;J)V

    .line 120
    invoke-direct {p0}, Lokhttp3/internal/sse/ServerSentEventReader;->skipCrAndOrLf()V

    .line 121
    return-void
.end method

.method private parseEvent(J)Ljava/lang/String;
    .locals 3
    .param p1, "end"    # J
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 124
    const/4 v0, 0x0

    .line 125
    .local v0, "type":Ljava/lang/String;
    const-wide/16 v1, 0x5

    invoke-direct {p0, v1, v2}, Lokhttp3/internal/sse/ServerSentEventReader;->skipNameAndDivider(J)J

    move-result-wide v1

    sub-long/2addr p1, v1

    .line 126
    const-wide/16 v1, 0x0

    cmp-long v1, p1, v1

    if-eqz v1, :cond_0

    .line 127
    iget-object v1, p0, Lokhttp3/internal/sse/ServerSentEventReader;->source:Lokio/BufferedSource;

    invoke-interface {v1, p1, p2}, Lokio/BufferedSource;->readUtf8(J)Ljava/lang/String;

    move-result-object v0

    .line 129
    :cond_0
    invoke-direct {p0}, Lokhttp3/internal/sse/ServerSentEventReader;->skipCrAndOrLf()V

    .line 130
    return-object v0
.end method

.method private parseId(J)Ljava/lang/String;
    .locals 2
    .param p1, "end"    # J
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 135
    const-wide/16 v0, 0x2

    invoke-direct {p0, v0, v1}, Lokhttp3/internal/sse/ServerSentEventReader;->skipNameAndDivider(J)J

    move-result-wide v0

    sub-long/2addr p1, v0

    .line 136
    const-wide/16 v0, 0x0

    cmp-long v0, p1, v0

    if-eqz v0, :cond_0

    .line 137
    iget-object v0, p0, Lokhttp3/internal/sse/ServerSentEventReader;->source:Lokio/BufferedSource;

    invoke-interface {v0, p1, p2}, Lokio/BufferedSource;->readUtf8(J)Ljava/lang/String;

    move-result-object v0

    .local v0, "id":Ljava/lang/String;
    goto :goto_0

    .line 139
    .end local v0    # "id":Ljava/lang/String;
    :cond_0
    const/4 v0, 0x0

    .line 141
    .restart local v0    # "id":Ljava/lang/String;
    :goto_0
    invoke-direct {p0}, Lokhttp3/internal/sse/ServerSentEventReader;->skipCrAndOrLf()V

    .line 142
    return-object v0
.end method

.method private parseRetry(J)V
    .locals 5
    .param p1, "end"    # J
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 146
    const-wide/16 v0, 0x5

    invoke-direct {p0, v0, v1}, Lokhttp3/internal/sse/ServerSentEventReader;->skipNameAndDivider(J)J

    move-result-wide v0

    sub-long/2addr p1, v0

    .line 147
    iget-object v0, p0, Lokhttp3/internal/sse/ServerSentEventReader;->source:Lokio/BufferedSource;

    invoke-interface {v0, p1, p2}, Lokio/BufferedSource;->readUtf8(J)Ljava/lang/String;

    move-result-object v0

    .line 148
    .local v0, "retryString":Ljava/lang/String;
    const-wide/16 v1, -0x1

    .line 150
    .local v1, "retryMs":J
    :try_start_0
    invoke-static {v0}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v3
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    move-wide v1, v3

    .line 152
    goto :goto_0

    .line 151
    :catch_0
    move-exception v3

    .line 153
    :goto_0
    const-wide/16 v3, -0x1

    cmp-long v3, v1, v3

    if-eqz v3, :cond_0

    .line 154
    iget-object v3, p0, Lokhttp3/internal/sse/ServerSentEventReader;->callback:Lokhttp3/internal/sse/ServerSentEventReader$Callback;

    invoke-interface {v3, v1, v2}, Lokhttp3/internal/sse/ServerSentEventReader$Callback;->onRetryChange(J)V

    .line 156
    :cond_0
    invoke-direct {p0}, Lokhttp3/internal/sse/ServerSentEventReader;->skipCrAndOrLf()V

    .line 157
    return-void
.end method

.method private skipCrAndOrLf()V
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 175
    iget-object v0, p0, Lokhttp3/internal/sse/ServerSentEventReader;->source:Lokio/BufferedSource;

    invoke-interface {v0}, Lokio/BufferedSource;->readByte()B

    move-result v0

    and-int/lit16 v0, v0, 0xff

    const/16 v1, 0xd

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lokhttp3/internal/sse/ServerSentEventReader;->source:Lokio/BufferedSource;

    .line 176
    const-wide/16 v1, 0x1

    invoke-interface {v0, v1, v2}, Lokio/BufferedSource;->request(J)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lokhttp3/internal/sse/ServerSentEventReader;->source:Lokio/BufferedSource;

    .line 177
    invoke-interface {v0}, Lokio/BufferedSource;->buffer()Lokio/Buffer;

    move-result-object v0

    const-wide/16 v3, 0x0

    invoke-virtual {v0, v3, v4}, Lokio/Buffer;->getByte(J)B

    move-result v0

    const/16 v3, 0xa

    if-ne v0, v3, :cond_0

    .line 178
    iget-object v0, p0, Lokhttp3/internal/sse/ServerSentEventReader;->source:Lokio/BufferedSource;

    invoke-interface {v0, v1, v2}, Lokio/BufferedSource;->skip(J)V

    .line 180
    :cond_0
    return-void
.end method

.method private skipNameAndDivider(J)J
    .locals 5
    .param p1, "length"    # J
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 187
    iget-object v0, p0, Lokhttp3/internal/sse/ServerSentEventReader;->source:Lokio/BufferedSource;

    invoke-interface {v0, p1, p2}, Lokio/BufferedSource;->skip(J)V

    .line 189
    iget-object v0, p0, Lokhttp3/internal/sse/ServerSentEventReader;->source:Lokio/BufferedSource;

    invoke-interface {v0}, Lokio/BufferedSource;->buffer()Lokio/Buffer;

    move-result-object v0

    const-wide/16 v1, 0x0

    invoke-virtual {v0, v1, v2}, Lokio/Buffer;->getByte(J)B

    move-result v0

    const/16 v3, 0x3a

    if-ne v0, v3, :cond_0

    .line 190
    iget-object v0, p0, Lokhttp3/internal/sse/ServerSentEventReader;->source:Lokio/BufferedSource;

    const-wide/16 v3, 0x1

    invoke-interface {v0, v3, v4}, Lokio/BufferedSource;->skip(J)V

    .line 191
    add-long/2addr p1, v3

    .line 193
    iget-object v0, p0, Lokhttp3/internal/sse/ServerSentEventReader;->source:Lokio/BufferedSource;

    invoke-interface {v0}, Lokio/BufferedSource;->buffer()Lokio/Buffer;

    move-result-object v0

    invoke-virtual {v0, v1, v2}, Lokio/Buffer;->getByte(J)B

    move-result v0

    const/16 v1, 0x20

    if-ne v0, v1, :cond_0

    .line 194
    iget-object v0, p0, Lokhttp3/internal/sse/ServerSentEventReader;->source:Lokio/BufferedSource;

    invoke-interface {v0, v3, v4}, Lokio/BufferedSource;->skip(J)V

    .line 195
    add-long/2addr p1, v3

    .line 199
    :cond_0
    return-wide p1
.end method


# virtual methods
.method processNextEvent()Z
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 56
    iget-object v0, p0, Lokhttp3/internal/sse/ServerSentEventReader;->lastId:Ljava/lang/String;

    .line 57
    .local v0, "id":Ljava/lang/String;
    const/4 v1, 0x0

    .line 58
    .local v1, "type":Ljava/lang/String;
    new-instance v2, Lokio/Buffer;

    invoke-direct {v2}, Lokio/Buffer;-><init>()V

    .line 61
    .local v2, "data":Lokio/Buffer;
    :goto_0
    iget-object v3, p0, Lokhttp3/internal/sse/ServerSentEventReader;->source:Lokio/BufferedSource;

    sget-object v4, Lokhttp3/internal/sse/ServerSentEventReader;->CRLF:Lokio/ByteString;

    invoke-interface {v3, v4}, Lokio/BufferedSource;->indexOfElement(Lokio/ByteString;)J

    move-result-wide v3

    .line 62
    .local v3, "lineEnd":J
    const-wide/16 v5, -0x1

    cmp-long v5, v3, v5

    if-nez v5, :cond_0

    .line 63
    const/4 v5, 0x0

    return v5

    .line 66
    :cond_0
    iget-object v5, p0, Lokhttp3/internal/sse/ServerSentEventReader;->source:Lokio/BufferedSource;

    invoke-interface {v5}, Lokio/BufferedSource;->buffer()Lokio/Buffer;

    move-result-object v5

    const-wide/16 v6, 0x0

    invoke-virtual {v5, v6, v7}, Lokio/Buffer;->getByte(J)B

    move-result v5

    sparse-switch v5, :sswitch_data_0

    goto :goto_1

    .line 94
    :sswitch_0
    sget-object v5, Lokhttp3/internal/sse/ServerSentEventReader;->RETRY:Lokio/ByteString;

    invoke-direct {p0, v5}, Lokhttp3/internal/sse/ServerSentEventReader;->isKey(Lokio/ByteString;)Z

    move-result v5

    if-eqz v5, :cond_1

    .line 95
    invoke-direct {p0, v3, v4}, Lokhttp3/internal/sse/ServerSentEventReader;->parseRetry(J)V

    .line 96
    goto :goto_0

    .line 87
    :sswitch_1
    sget-object v5, Lokhttp3/internal/sse/ServerSentEventReader;->ID:Lokio/ByteString;

    invoke-direct {p0, v5}, Lokhttp3/internal/sse/ServerSentEventReader;->isKey(Lokio/ByteString;)Z

    move-result v5

    if-eqz v5, :cond_1

    .line 88
    invoke-direct {p0, v3, v4}, Lokhttp3/internal/sse/ServerSentEventReader;->parseId(J)Ljava/lang/String;

    move-result-object v0

    .line 89
    goto :goto_0

    .line 80
    :sswitch_2
    sget-object v5, Lokhttp3/internal/sse/ServerSentEventReader;->EVENT:Lokio/ByteString;

    invoke-direct {p0, v5}, Lokhttp3/internal/sse/ServerSentEventReader;->isKey(Lokio/ByteString;)Z

    move-result v5

    if-eqz v5, :cond_1

    .line 81
    invoke-direct {p0, v3, v4}, Lokhttp3/internal/sse/ServerSentEventReader;->parseEvent(J)Ljava/lang/String;

    move-result-object v1

    .line 82
    goto :goto_0

    .line 73
    :sswitch_3
    sget-object v5, Lokhttp3/internal/sse/ServerSentEventReader;->DATA:Lokio/ByteString;

    invoke-direct {p0, v5}, Lokhttp3/internal/sse/ServerSentEventReader;->isKey(Lokio/ByteString;)Z

    move-result v5

    if-eqz v5, :cond_1

    .line 74
    invoke-direct {p0, v2, v3, v4}, Lokhttp3/internal/sse/ServerSentEventReader;->parseData(Lokio/Buffer;J)V

    .line 75
    goto :goto_0

    .line 69
    :sswitch_4
    invoke-direct {p0, v0, v1, v2}, Lokhttp3/internal/sse/ServerSentEventReader;->completeEvent(Ljava/lang/String;Ljava/lang/String;Lokio/Buffer;)V

    .line 70
    const/4 v5, 0x1

    return v5

    .line 101
    :cond_1
    :goto_1
    iget-object v5, p0, Lokhttp3/internal/sse/ServerSentEventReader;->source:Lokio/BufferedSource;

    invoke-interface {v5, v3, v4}, Lokio/BufferedSource;->skip(J)V

    .line 102
    invoke-direct {p0}, Lokhttp3/internal/sse/ServerSentEventReader;->skipCrAndOrLf()V

    .line 103
    .end local v3    # "lineEnd":J
    goto :goto_0

    :sswitch_data_0
    .sparse-switch
        0xa -> :sswitch_4
        0xd -> :sswitch_4
        0x64 -> :sswitch_3
        0x65 -> :sswitch_2
        0x69 -> :sswitch_1
        0x72 -> :sswitch_0
    .end sparse-switch
.end method
