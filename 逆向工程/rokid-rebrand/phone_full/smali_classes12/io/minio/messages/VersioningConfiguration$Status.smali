.class public final enum Lio/minio/messages/VersioningConfiguration$Status;
.super Ljava/lang/Enum;
.source "VersioningConfiguration.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/minio/messages/VersioningConfiguration;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "Status"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lio/minio/messages/VersioningConfiguration$Status;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lio/minio/messages/VersioningConfiguration$Status;

.field public static final enum ENABLED:Lio/minio/messages/VersioningConfiguration$Status;

.field public static final enum OFF:Lio/minio/messages/VersioningConfiguration$Status;

.field public static final enum SUSPENDED:Lio/minio/messages/VersioningConfiguration$Status;


# instance fields
.field private final value:Ljava/lang/String;


# direct methods
.method private static synthetic $values()[Lio/minio/messages/VersioningConfiguration$Status;
    .locals 3

    .line 68
    sget-object v0, Lio/minio/messages/VersioningConfiguration$Status;->OFF:Lio/minio/messages/VersioningConfiguration$Status;

    sget-object v1, Lio/minio/messages/VersioningConfiguration$Status;->ENABLED:Lio/minio/messages/VersioningConfiguration$Status;

    sget-object v2, Lio/minio/messages/VersioningConfiguration$Status;->SUSPENDED:Lio/minio/messages/VersioningConfiguration$Status;

    filled-new-array {v0, v1, v2}, [Lio/minio/messages/VersioningConfiguration$Status;

    move-result-object v0

    return-object v0
.end method

.method static constructor <clinit>()V
    .locals 4

    .line 69
    new-instance v0, Lio/minio/messages/VersioningConfiguration$Status;

    const/4 v1, 0x0

    const-string v2, ""

    const-string v3, "OFF"

    invoke-direct {v0, v3, v1, v2}, Lio/minio/messages/VersioningConfiguration$Status;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lio/minio/messages/VersioningConfiguration$Status;->OFF:Lio/minio/messages/VersioningConfiguration$Status;

    .line 70
    new-instance v0, Lio/minio/messages/VersioningConfiguration$Status;

    const/4 v1, 0x1

    const-string v2, "Enabled"

    const-string v3, "ENABLED"

    invoke-direct {v0, v3, v1, v2}, Lio/minio/messages/VersioningConfiguration$Status;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lio/minio/messages/VersioningConfiguration$Status;->ENABLED:Lio/minio/messages/VersioningConfiguration$Status;

    .line 71
    new-instance v0, Lio/minio/messages/VersioningConfiguration$Status;

    const/4 v1, 0x2

    const-string v2, "Suspended"

    const-string v3, "SUSPENDED"

    invoke-direct {v0, v3, v1, v2}, Lio/minio/messages/VersioningConfiguration$Status;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lio/minio/messages/VersioningConfiguration$Status;->SUSPENDED:Lio/minio/messages/VersioningConfiguration$Status;

    .line 68
    invoke-static {}, Lio/minio/messages/VersioningConfiguration$Status;->$values()[Lio/minio/messages/VersioningConfiguration$Status;

    move-result-object v0

    sput-object v0, Lio/minio/messages/VersioningConfiguration$Status;->$VALUES:[Lio/minio/messages/VersioningConfiguration$Status;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;ILjava/lang/String;)V
    .locals 0
    .param p3, "value"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .line 75
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    .line 76
    iput-object p3, p0, Lio/minio/messages/VersioningConfiguration$Status;->value:Ljava/lang/String;

    .line 77
    return-void
.end method

.method public static fromString(Ljava/lang/String;)Lio/minio/messages/VersioningConfiguration$Status;
    .locals 1
    .param p0, "statusString"    # Ljava/lang/String;

    .line 84
    const-string v0, "Enabled"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 85
    sget-object v0, Lio/minio/messages/VersioningConfiguration$Status;->ENABLED:Lio/minio/messages/VersioningConfiguration$Status;

    return-object v0

    .line 88
    :cond_0
    const-string v0, "Suspended"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 89
    sget-object v0, Lio/minio/messages/VersioningConfiguration$Status;->SUSPENDED:Lio/minio/messages/VersioningConfiguration$Status;

    return-object v0

    .line 92
    :cond_1
    sget-object v0, Lio/minio/messages/VersioningConfiguration$Status;->OFF:Lio/minio/messages/VersioningConfiguration$Status;

    return-object v0
.end method

.method public static valueOf(Ljava/lang/String;)Lio/minio/messages/VersioningConfiguration$Status;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .line 68
    const-class v0, Lio/minio/messages/VersioningConfiguration$Status;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lio/minio/messages/VersioningConfiguration$Status;

    return-object v0
.end method

.method public static values()[Lio/minio/messages/VersioningConfiguration$Status;
    .locals 1

    .line 68
    sget-object v0, Lio/minio/messages/VersioningConfiguration$Status;->$VALUES:[Lio/minio/messages/VersioningConfiguration$Status;

    invoke-virtual {v0}, [Lio/minio/messages/VersioningConfiguration$Status;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lio/minio/messages/VersioningConfiguration$Status;

    return-object v0
.end method


# virtual methods
.method public toString()Ljava/lang/String;
    .locals 1

    .line 80
    iget-object v0, p0, Lio/minio/messages/VersioningConfiguration$Status;->value:Ljava/lang/String;

    return-object v0
.end method
