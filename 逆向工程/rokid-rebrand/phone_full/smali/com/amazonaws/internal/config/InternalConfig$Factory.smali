.class public Lcom/amazonaws/internal/config/InternalConfig$Factory;
.super Ljava/lang/Object;
.source "InternalConfig.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/amazonaws/internal/config/InternalConfig;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "Factory"
.end annotation


# static fields
.field private static final SINGELTON:Lcom/amazonaws/internal/config/InternalConfig;


# direct methods
.method static constructor <clinit>()V
    .locals 4

    .line 196
    const/4 v0, 0x0

    .line 198
    .local v0, "config":Lcom/amazonaws/internal/config/InternalConfig;
    :try_start_0
    new-instance v1, Lcom/amazonaws/internal/config/InternalConfig;

    invoke-direct {v1}, Lcom/amazonaws/internal/config/InternalConfig;-><init>()V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-object v0, v1

    .line 205
    nop

    .line 206
    sput-object v0, Lcom/amazonaws/internal/config/InternalConfig$Factory;->SINGELTON:Lcom/amazonaws/internal/config/InternalConfig;

    .line 207
    .end local v0    # "config":Lcom/amazonaws/internal/config/InternalConfig;
    return-void

    .line 201
    .restart local v0    # "config":Lcom/amazonaws/internal/config/InternalConfig;
    :catch_0
    move-exception v1

    .line 202
    .local v1, "ex":Ljava/lang/Exception;
    new-instance v2, Ljava/lang/IllegalStateException;

    const-string v3, "Fatal: Failed to load the internal config for AWS Android SDK"

    invoke-direct {v2, v3, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v2

    .line 199
    .end local v1    # "ex":Ljava/lang/Exception;
    :catch_1
    move-exception v1

    .line 200
    .local v1, "ex":Ljava/lang/RuntimeException;
    throw v1
.end method

.method public constructor <init>()V
    .locals 0

    .line 193
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getInternalConfig()Lcom/amazonaws/internal/config/InternalConfig;
    .locals 1

    .line 214
    sget-object v0, Lcom/amazonaws/internal/config/InternalConfig$Factory;->SINGELTON:Lcom/amazonaws/internal/config/InternalConfig;

    return-object v0
.end method
