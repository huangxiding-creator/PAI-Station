.class public Lio/minio/errors/MinioException;
.super Ljava/lang/Exception;
.source "MinioException.java"


# static fields
.field private static final serialVersionUID:J = -0x647d3c8539c79f62L


# instance fields
.field httpTrace:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 27
    invoke-direct {p0}, Ljava/lang/Exception;-><init>()V

    .line 23
    const/4 v0, 0x0

    iput-object v0, p0, Lio/minio/errors/MinioException;->httpTrace:Ljava/lang/String;

    .line 28
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;)V
    .locals 1
    .param p1, "message"    # Ljava/lang/String;

    .line 32
    invoke-direct {p0, p1}, Ljava/lang/Exception;-><init>(Ljava/lang/String;)V

    .line 23
    const/4 v0, 0x0

    iput-object v0, p0, Lio/minio/errors/MinioException;->httpTrace:Ljava/lang/String;

    .line 33
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "message"    # Ljava/lang/String;
    .param p2, "httpTrace"    # Ljava/lang/String;

    .line 37
    invoke-direct {p0, p1}, Ljava/lang/Exception;-><init>(Ljava/lang/String;)V

    .line 23
    const/4 v0, 0x0

    iput-object v0, p0, Lio/minio/errors/MinioException;->httpTrace:Ljava/lang/String;

    .line 38
    iput-object p2, p0, Lio/minio/errors/MinioException;->httpTrace:Ljava/lang/String;

    .line 39
    return-void
.end method


# virtual methods
.method public httpTrace()Ljava/lang/String;
    .locals 1

    .line 42
    iget-object v0, p0, Lio/minio/errors/MinioException;->httpTrace:Ljava/lang/String;

    return-object v0
.end method
