.class public Lcom/alibaba/sdk/android/oss/signer/SignParameters;
.super Ljava/lang/Object;
.source "SignParameters.java"


# static fields
.field public static final AUTHORIZATION_PREFIX:Ljava/lang/String; = "OSS "

.field public static final NEW_LINE:Ljava/lang/String; = "\n"

.field public static final SIGNED_PARAMTERS:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .line 39
    const/16 v0, 0x1b

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "bucketInfo"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, "acl"

    aput-object v2, v0, v1

    const/4 v1, 0x2

    const-string/jumbo v2, "uploads"

    aput-object v2, v0, v1

    const/4 v1, 0x3

    const-string v2, "location"

    aput-object v2, v0, v1

    const/4 v1, 0x4

    const-string v2, "cors"

    aput-object v2, v0, v1

    const/4 v1, 0x5

    const-string v2, "logging"

    aput-object v2, v0, v1

    const/4 v1, 0x6

    const-string/jumbo v2, "website"

    aput-object v2, v0, v1

    const/4 v1, 0x7

    const-string v2, "referer"

    aput-object v2, v0, v1

    const/16 v1, 0x8

    const-string v2, "lifecycle"

    aput-object v2, v0, v1

    const/16 v1, 0x9

    const-string v2, "delete"

    aput-object v2, v0, v1

    const/16 v1, 0xa

    const-string v2, "append"

    aput-object v2, v0, v1

    const/16 v1, 0xb

    const-string/jumbo v2, "uploadId"

    aput-object v2, v0, v1

    const/16 v1, 0xc

    const-string v2, "partNumber"

    aput-object v2, v0, v1

    const/16 v1, 0xd

    const-string v2, "security-token"

    aput-object v2, v0, v1

    const/16 v1, 0xe

    const-string v2, "position"

    aput-object v2, v0, v1

    const/16 v1, 0xf

    const-string v2, "response-cache-control"

    aput-object v2, v0, v1

    const/16 v1, 0x10

    const-string v2, "response-content-disposition"

    aput-object v2, v0, v1

    const/16 v1, 0x11

    const-string v2, "response-content-encoding"

    aput-object v2, v0, v1

    const/16 v1, 0x12

    const-string v2, "response-content-language"

    aput-object v2, v0, v1

    const/16 v1, 0x13

    const-string v2, "response-content-type"

    aput-object v2, v0, v1

    const/16 v1, 0x14

    const-string v2, "response-expires"

    aput-object v2, v0, v1

    const/16 v1, 0x15

    const-string/jumbo v2, "x-oss-process"

    aput-object v2, v0, v1

    const/16 v1, 0x16

    const-string v2, "sequential"

    aput-object v2, v0, v1

    const/16 v1, 0x17

    const-string/jumbo v2, "symlink"

    aput-object v2, v0, v1

    const/16 v1, 0x18

    const-string v2, "restore"

    aput-object v2, v0, v1

    const/16 v1, 0x19

    const-string/jumbo v2, "tagging"

    aput-object v2, v0, v1

    const/16 v1, 0x1a

    const-string v2, "objectMeta"

    aput-object v2, v0, v1

    invoke-static {v0}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    sput-object v0, Lcom/alibaba/sdk/android/oss/signer/SignParameters;->SIGNED_PARAMTERS:Ljava/util/List;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 35
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
