.class Lio/minio/credentials/AwsConfigProvider$Ini;
.super Ljava/lang/Object;
.source "AwsConfigProvider.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/minio/credentials/AwsConfigProvider;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "Ini"
.end annotation


# instance fields
.field private result:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/util/Properties;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method private constructor <init>()V
    .locals 1

    .line 106
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 107
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lio/minio/credentials/AwsConfigProvider$Ini;->result:Ljava/util/Map;

    return-void
.end method

.method synthetic constructor <init>(Lio/minio/credentials/AwsConfigProvider$1;)V
    .locals 0
    .param p1, "x0"    # Lio/minio/credentials/AwsConfigProvider$1;

    .line 106
    invoke-direct {p0}, Lio/minio/credentials/AwsConfigProvider$Ini;-><init>()V

    return-void
.end method

.method static synthetic access$100(Lio/minio/credentials/AwsConfigProvider$Ini;)Ljava/util/Map;
    .locals 1
    .param p0, "x0"    # Lio/minio/credentials/AwsConfigProvider$Ini;

    .line 106
    iget-object v0, p0, Lio/minio/credentials/AwsConfigProvider$Ini;->result:Ljava/util/Map;

    return-object v0
.end method


# virtual methods
.method public unmarshal(Ljava/io/Reader;)Ljava/util/Map;
    .locals 1
    .param p1, "reader"    # Ljava/io/Reader;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/io/Reader;",
            ")",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/util/Properties;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 110
    new-instance v0, Lio/minio/credentials/AwsConfigProvider$Ini$1;

    invoke-direct {v0, p0}, Lio/minio/credentials/AwsConfigProvider$Ini$1;-><init>(Lio/minio/credentials/AwsConfigProvider$Ini;)V

    .line 132
    invoke-virtual {v0, p1}, Lio/minio/credentials/AwsConfigProvider$Ini$1;->load(Ljava/io/Reader;)V

    .line 134
    iget-object v0, p0, Lio/minio/credentials/AwsConfigProvider$Ini;->result:Ljava/util/Map;

    return-object v0
.end method
