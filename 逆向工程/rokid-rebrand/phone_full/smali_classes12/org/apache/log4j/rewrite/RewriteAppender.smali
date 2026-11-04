.class public Lorg/apache/log4j/rewrite/RewriteAppender;
.super Lorg/apache/log4j/AppenderSkeleton;
.source "RewriteAppender.java"

# interfaces
.implements Lorg/apache/log4j/spi/AppenderAttachable;
.implements Lorg/apache/log4j/xml/UnrecognizedElementHandler;


# static fields
.field static synthetic class$org$apache$log4j$rewrite$RewritePolicy:Ljava/lang/Class;


# instance fields
.field private final appenders:Lorg/apache/log4j/helpers/AppenderAttachableImpl;

.field private policy:Lorg/apache/log4j/rewrite/RewritePolicy;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 50
    invoke-direct {p0}, Lorg/apache/log4j/AppenderSkeleton;-><init>()V

    .line 51
    new-instance v0, Lorg/apache/log4j/helpers/AppenderAttachableImpl;

    invoke-direct {v0}, Lorg/apache/log4j/helpers/AppenderAttachableImpl;-><init>()V

    iput-object v0, p0, Lorg/apache/log4j/rewrite/RewriteAppender;->appenders:Lorg/apache/log4j/helpers/AppenderAttachableImpl;

    .line 52
    return-void
.end method

.method static synthetic class$(Ljava/lang/String;)Ljava/lang/Class;
    .locals 2
    .param p0, "x0"    # Ljava/lang/String;

    .line 187
    :try_start_0
    invoke-static {p0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    move-exception v0

    .local v0, "x1":Ljava/lang/ClassNotFoundException;
    new-instance v1, Ljava/lang/NoClassDefFoundError;

    invoke-direct {v1}, Ljava/lang/NoClassDefFoundError;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/NoClassDefFoundError;->initCause(Ljava/lang/Throwable;)Ljava/lang/Throwable;

    move-result-object v1

    throw v1
.end method


# virtual methods
.method public addAppender(Lorg/apache/log4j/Appender;)V
    .locals 2
    .param p1, "newAppender"    # Lorg/apache/log4j/Appender;

    .line 75
    iget-object v0, p0, Lorg/apache/log4j/rewrite/RewriteAppender;->appenders:Lorg/apache/log4j/helpers/AppenderAttachableImpl;

    monitor-enter v0

    .line 76
    :try_start_0
    iget-object v1, p0, Lorg/apache/log4j/rewrite/RewriteAppender;->appenders:Lorg/apache/log4j/helpers/AppenderAttachableImpl;

    invoke-virtual {v1, p1}, Lorg/apache/log4j/helpers/AppenderAttachableImpl;->addAppender(Lorg/apache/log4j/Appender;)V

    .line 77
    monitor-exit v0

    .line 78
    return-void

    .line 77
    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method protected append(Lorg/apache/log4j/spi/LoggingEvent;)V
    .locals 3
    .param p1, "event"    # Lorg/apache/log4j/spi/LoggingEvent;

    .line 58
    move-object v0, p1

    .line 59
    .local v0, "rewritten":Lorg/apache/log4j/spi/LoggingEvent;
    iget-object v1, p0, Lorg/apache/log4j/rewrite/RewriteAppender;->policy:Lorg/apache/log4j/rewrite/RewritePolicy;

    if-eqz v1, :cond_0

    .line 60
    iget-object v1, p0, Lorg/apache/log4j/rewrite/RewriteAppender;->policy:Lorg/apache/log4j/rewrite/RewritePolicy;

    invoke-interface {v1, p1}, Lorg/apache/log4j/rewrite/RewritePolicy;->rewrite(Lorg/apache/log4j/spi/LoggingEvent;)Lorg/apache/log4j/spi/LoggingEvent;

    move-result-object v0

    .line 62
    :cond_0
    if-eqz v0, :cond_1

    .line 63
    iget-object v1, p0, Lorg/apache/log4j/rewrite/RewriteAppender;->appenders:Lorg/apache/log4j/helpers/AppenderAttachableImpl;

    monitor-enter v1

    .line 64
    :try_start_0
    iget-object v2, p0, Lorg/apache/log4j/rewrite/RewriteAppender;->appenders:Lorg/apache/log4j/helpers/AppenderAttachableImpl;

    invoke-virtual {v2, v0}, Lorg/apache/log4j/helpers/AppenderAttachableImpl;->appendLoopOnAppenders(Lorg/apache/log4j/spi/LoggingEvent;)I

    .line 65
    monitor-exit v1

    goto :goto_0

    :catchall_0
    move-exception v2

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v2

    .line 67
    :cond_1
    :goto_0
    return-void
.end method

.method public close()V
    .locals 4

    .line 108
    const/4 v0, 0x1

    iput-boolean v0, p0, Lorg/apache/log4j/rewrite/RewriteAppender;->closed:Z

    .line 112
    iget-object v0, p0, Lorg/apache/log4j/rewrite/RewriteAppender;->appenders:Lorg/apache/log4j/helpers/AppenderAttachableImpl;

    monitor-enter v0

    .line 113
    :try_start_0
    iget-object v1, p0, Lorg/apache/log4j/rewrite/RewriteAppender;->appenders:Lorg/apache/log4j/helpers/AppenderAttachableImpl;

    invoke-virtual {v1}, Lorg/apache/log4j/helpers/AppenderAttachableImpl;->getAllAppenders()Ljava/util/Enumeration;

    move-result-object v1

    .line 115
    .local v1, "iter":Ljava/util/Enumeration;
    if-eqz v1, :cond_1

    .line 116
    :goto_0
    invoke-interface {v1}, Ljava/util/Enumeration;->hasMoreElements()Z

    move-result v2

    if-eqz v2, :cond_1

    .line 117
    invoke-interface {v1}, Ljava/util/Enumeration;->nextElement()Ljava/lang/Object;

    move-result-object v2

    .line 119
    .local v2, "next":Ljava/lang/Object;
    instance-of v3, v2, Lorg/apache/log4j/Appender;

    if-eqz v3, :cond_0

    .line 120
    move-object v3, v2

    check-cast v3, Lorg/apache/log4j/Appender;

    invoke-interface {v3}, Lorg/apache/log4j/Appender;->close()V

    .line 122
    .end local v2    # "next":Ljava/lang/Object;
    :cond_0
    goto :goto_0

    .line 124
    .end local v1    # "iter":Ljava/util/Enumeration;
    :cond_1
    monitor-exit v0

    .line 125
    return-void

    .line 124
    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method public getAllAppenders()Ljava/util/Enumeration;
    .locals 2

    .line 85
    iget-object v0, p0, Lorg/apache/log4j/rewrite/RewriteAppender;->appenders:Lorg/apache/log4j/helpers/AppenderAttachableImpl;

    monitor-enter v0

    .line 86
    :try_start_0
    iget-object v1, p0, Lorg/apache/log4j/rewrite/RewriteAppender;->appenders:Lorg/apache/log4j/helpers/AppenderAttachableImpl;

    invoke-virtual {v1}, Lorg/apache/log4j/helpers/AppenderAttachableImpl;->getAllAppenders()Ljava/util/Enumeration;

    move-result-object v1

    monitor-exit v0

    return-object v1

    .line 87
    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method public getAppender(Ljava/lang/String;)Lorg/apache/log4j/Appender;
    .locals 2
    .param p1, "name"    # Ljava/lang/String;

    .line 97
    iget-object v0, p0, Lorg/apache/log4j/rewrite/RewriteAppender;->appenders:Lorg/apache/log4j/helpers/AppenderAttachableImpl;

    monitor-enter v0

    .line 98
    :try_start_0
    iget-object v1, p0, Lorg/apache/log4j/rewrite/RewriteAppender;->appenders:Lorg/apache/log4j/helpers/AppenderAttachableImpl;

    invoke-virtual {v1, p1}, Lorg/apache/log4j/helpers/AppenderAttachableImpl;->getAppender(Ljava/lang/String;)Lorg/apache/log4j/Appender;

    move-result-object v1

    monitor-exit v0

    return-object v1

    .line 99
    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method public isAttached(Lorg/apache/log4j/Appender;)Z
    .locals 2
    .param p1, "appender"    # Lorg/apache/log4j/Appender;

    .line 133
    iget-object v0, p0, Lorg/apache/log4j/rewrite/RewriteAppender;->appenders:Lorg/apache/log4j/helpers/AppenderAttachableImpl;

    monitor-enter v0

    .line 134
    :try_start_0
    iget-object v1, p0, Lorg/apache/log4j/rewrite/RewriteAppender;->appenders:Lorg/apache/log4j/helpers/AppenderAttachableImpl;

    invoke-virtual {v1, p1}, Lorg/apache/log4j/helpers/AppenderAttachableImpl;->isAttached(Lorg/apache/log4j/Appender;)Z

    move-result v1

    monitor-exit v0

    return v1

    .line 135
    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method public parseUnrecognizedElement(Lorg/w3c/dom/Element;Ljava/util/Properties;)Z
    .locals 3
    .param p1, "element"    # Lorg/w3c/dom/Element;
    .param p2, "props"    # Ljava/util/Properties;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 183
    invoke-interface {p1}, Lorg/w3c/dom/Element;->getNodeName()Ljava/lang/String;

    move-result-object v0

    .line 184
    .local v0, "nodeName":Ljava/lang/String;
    const-string v1, "rewritePolicy"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_3

    .line 185
    sget-object v1, Lorg/apache/log4j/rewrite/RewriteAppender;->class$org$apache$log4j$rewrite$RewritePolicy:Ljava/lang/Class;

    if-nez v1, :cond_0

    const-string v1, "org.apache.log4j.rewrite.RewritePolicy"

    invoke-static {v1}, Lorg/apache/log4j/rewrite/RewriteAppender;->class$(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v1

    sput-object v1, Lorg/apache/log4j/rewrite/RewriteAppender;->class$org$apache$log4j$rewrite$RewritePolicy:Ljava/lang/Class;

    goto :goto_0

    :cond_0
    sget-object v1, Lorg/apache/log4j/rewrite/RewriteAppender;->class$org$apache$log4j$rewrite$RewritePolicy:Ljava/lang/Class;

    :goto_0
    invoke-static {p1, p2, v1}, Lorg/apache/log4j/xml/DOMConfigurator;->parseElement(Lorg/w3c/dom/Element;Ljava/util/Properties;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v1

    .line 188
    .local v1, "rewritePolicy":Ljava/lang/Object;
    if-eqz v1, :cond_2

    .line 189
    instance-of v2, v1, Lorg/apache/log4j/spi/OptionHandler;

    if-eqz v2, :cond_1

    .line 190
    move-object v2, v1

    check-cast v2, Lorg/apache/log4j/spi/OptionHandler;

    invoke-interface {v2}, Lorg/apache/log4j/spi/OptionHandler;->activateOptions()V

    .line 192
    :cond_1
    move-object v2, v1

    check-cast v2, Lorg/apache/log4j/rewrite/RewritePolicy;

    invoke-virtual {p0, v2}, Lorg/apache/log4j/rewrite/RewriteAppender;->setRewritePolicy(Lorg/apache/log4j/rewrite/RewritePolicy;)V

    .line 194
    :cond_2
    const/4 v2, 0x1

    return v2

    .line 196
    .end local v1    # "rewritePolicy":Ljava/lang/Object;
    :cond_3
    const/4 v1, 0x0

    return v1
.end method

.method public removeAllAppenders()V
    .locals 2

    .line 149
    iget-object v0, p0, Lorg/apache/log4j/rewrite/RewriteAppender;->appenders:Lorg/apache/log4j/helpers/AppenderAttachableImpl;

    monitor-enter v0

    .line 150
    :try_start_0
    iget-object v1, p0, Lorg/apache/log4j/rewrite/RewriteAppender;->appenders:Lorg/apache/log4j/helpers/AppenderAttachableImpl;

    invoke-virtual {v1}, Lorg/apache/log4j/helpers/AppenderAttachableImpl;->removeAllAppenders()V

    .line 151
    monitor-exit v0

    .line 152
    return-void

    .line 151
    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method public removeAppender(Ljava/lang/String;)V
    .locals 2
    .param p1, "name"    # Ljava/lang/String;

    .line 169
    iget-object v0, p0, Lorg/apache/log4j/rewrite/RewriteAppender;->appenders:Lorg/apache/log4j/helpers/AppenderAttachableImpl;

    monitor-enter v0

    .line 170
    :try_start_0
    iget-object v1, p0, Lorg/apache/log4j/rewrite/RewriteAppender;->appenders:Lorg/apache/log4j/helpers/AppenderAttachableImpl;

    invoke-virtual {v1, p1}, Lorg/apache/log4j/helpers/AppenderAttachableImpl;->removeAppender(Ljava/lang/String;)V

    .line 171
    monitor-exit v0

    .line 172
    return-void

    .line 171
    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method public removeAppender(Lorg/apache/log4j/Appender;)V
    .locals 2
    .param p1, "appender"    # Lorg/apache/log4j/Appender;

    .line 159
    iget-object v0, p0, Lorg/apache/log4j/rewrite/RewriteAppender;->appenders:Lorg/apache/log4j/helpers/AppenderAttachableImpl;

    monitor-enter v0

    .line 160
    :try_start_0
    iget-object v1, p0, Lorg/apache/log4j/rewrite/RewriteAppender;->appenders:Lorg/apache/log4j/helpers/AppenderAttachableImpl;

    invoke-virtual {v1, p1}, Lorg/apache/log4j/helpers/AppenderAttachableImpl;->removeAppender(Lorg/apache/log4j/Appender;)V

    .line 161
    monitor-exit v0

    .line 162
    return-void

    .line 161
    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method public requiresLayout()Z
    .locals 1

    .line 142
    const/4 v0, 0x0

    return v0
.end method

.method public setRewritePolicy(Lorg/apache/log4j/rewrite/RewritePolicy;)V
    .locals 0
    .param p1, "rewritePolicy"    # Lorg/apache/log4j/rewrite/RewritePolicy;

    .line 176
    iput-object p1, p0, Lorg/apache/log4j/rewrite/RewriteAppender;->policy:Lorg/apache/log4j/rewrite/RewritePolicy;

    .line 177
    return-void
.end method
