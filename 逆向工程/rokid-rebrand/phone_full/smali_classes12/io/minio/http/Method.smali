.class public final enum Lio/minio/http/Method;
.super Ljava/lang/Enum;
.source "Method.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lio/minio/http/Method;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lio/minio/http/Method;

.field public static final enum DELETE:Lio/minio/http/Method;

.field public static final enum GET:Lio/minio/http/Method;

.field public static final enum HEAD:Lio/minio/http/Method;

.field public static final enum POST:Lio/minio/http/Method;

.field public static final enum PUT:Lio/minio/http/Method;


# direct methods
.method private static synthetic $values()[Lio/minio/http/Method;
    .locals 5

    .line 20
    sget-object v0, Lio/minio/http/Method;->GET:Lio/minio/http/Method;

    sget-object v1, Lio/minio/http/Method;->HEAD:Lio/minio/http/Method;

    sget-object v2, Lio/minio/http/Method;->POST:Lio/minio/http/Method;

    sget-object v3, Lio/minio/http/Method;->PUT:Lio/minio/http/Method;

    sget-object v4, Lio/minio/http/Method;->DELETE:Lio/minio/http/Method;

    filled-new-array {v0, v1, v2, v3, v4}, [Lio/minio/http/Method;

    move-result-object v0

    return-object v0
.end method

.method static constructor <clinit>()V
    .locals 3

    .line 21
    new-instance v0, Lio/minio/http/Method;

    const-string v1, "GET"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lio/minio/http/Method;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lio/minio/http/Method;->GET:Lio/minio/http/Method;

    .line 22
    new-instance v0, Lio/minio/http/Method;

    const-string v1, "HEAD"

    const/4 v2, 0x1

    invoke-direct {v0, v1, v2}, Lio/minio/http/Method;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lio/minio/http/Method;->HEAD:Lio/minio/http/Method;

    .line 23
    new-instance v0, Lio/minio/http/Method;

    const-string v1, "POST"

    const/4 v2, 0x2

    invoke-direct {v0, v1, v2}, Lio/minio/http/Method;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lio/minio/http/Method;->POST:Lio/minio/http/Method;

    .line 24
    new-instance v0, Lio/minio/http/Method;

    const-string v1, "PUT"

    const/4 v2, 0x3

    invoke-direct {v0, v1, v2}, Lio/minio/http/Method;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lio/minio/http/Method;->PUT:Lio/minio/http/Method;

    .line 25
    new-instance v0, Lio/minio/http/Method;

    const-string v1, "DELETE"

    const/4 v2, 0x4

    invoke-direct {v0, v1, v2}, Lio/minio/http/Method;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lio/minio/http/Method;->DELETE:Lio/minio/http/Method;

    .line 20
    invoke-static {}, Lio/minio/http/Method;->$values()[Lio/minio/http/Method;

    move-result-object v0

    sput-object v0, Lio/minio/http/Method;->$VALUES:[Lio/minio/http/Method;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 20
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lio/minio/http/Method;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .line 20
    const-class v0, Lio/minio/http/Method;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lio/minio/http/Method;

    return-object v0
.end method

.method public static values()[Lio/minio/http/Method;
    .locals 1

    .line 20
    sget-object v0, Lio/minio/http/Method;->$VALUES:[Lio/minio/http/Method;

    invoke-virtual {v0}, [Lio/minio/http/Method;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lio/minio/http/Method;

    return-object v0
.end method
